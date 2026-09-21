# Moving this setup to a new Windows machine

Written for the case where the data disk travels with you. What is on `D:` at
shutdown arrives on the other machine; everything else has to be copied onto
`D:` first, or it is gone.

Assumptions, all of them checkable with the commands below:

- scoop lives in `D:\scoop`, this repo in `D:\Github\dotfiles`
- the WSL distribution is named `Ubuntu-24.04` (the wezterm config starts it by
  that exact name)
- the account you work with is a standard user; elevation happens through a
  separate admin account

## Phase A - on the old machine, before the disk is pulled

### A1. Can the disk be read afterwards at all?

```powershell
manage-bde -status D:
```

If it is encrypted, get the recovery key first. The new machine has a different
TPM and will ask for it.

### A2. Export the package list

```powershell
cd D:\Github\dotfiles
scoop export -c > windows\scoop.json
git add windows\scoop.json
git commit -m "windows: scoop export"
git push
```

Not strictly needed while `D:\scoop` travels with the disk, but it is the only
thing that rebuilds the installation if the disk does not make it.

### A3. Empty the caches, then export WSL

```bash
rm -rf ~/.cache/pip ~/.cache/packman        # both are rebuilt on demand
# plus whatever else is large and reproducible
du -xh --max-depth=1 ~ | sort -rh | head
```

```powershell
wsl -l -v                  # note every distribution you want to keep
wsl --shutdown
wsl --export Ubuntu-24.04 D:\wsl-ubuntu-24.04.tar
```

**After this export, stop working inside WSL.** The tar is a snapshot;
everything you change afterwards stays behind on the old machine.

### A4. Copy off what lives in the Windows profile

`C:` does not travel. Collect into `D:\transfer\`:

| From | Why |
|---|---|
| `C:\Users\<user>\.ssh` | keys, `config`, `known_hosts` |
| PowerToys backup | Settings > Backup & Restore > Backup |
| `%APPDATA%\Microsoft\Signatures` | Outlook signatures |
| Browser profile or a sync login | bookmarks, saved logins |
| Downloads, Desktop, certificates | whatever is not in git |

### A5. Push the repository

```powershell
cd D:\Github\dotfiles
git status                 # anything uncommitted is only on this disk
git push
```

## Phase B - on the new machine

### B0. Local, in an elevated session of the admin account

An SSH session can never elevate: UAC has no way to ask. So everything that
needs admin rights happens here, once.

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd; Set-Service sshd -StartupType Automatic

New-ItemProperty -Path 'HKLM:\SOFTWARE\OpenSSH' -Name DefaultShell `
  -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -PropertyType String -Force

# lets a standard user create symlinks, which deploy.ps1 needs
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' `
  -Name AllowDevelopmentWithoutDevLicense -Value 1 -PropertyType DWord -Force
```

If `Add-WindowsCapability` fails with `0x800f0954`, features on demand are
blocked by policy. Use scoop instead:

```powershell
scoop install openssh
D:\scoop\apps\openssh\current\install-sshd.ps1
```

Optional but only possible here:

- **AutoHotkey under `C:\Program Files\AutoHotkey` with "Enable UI Access".**
  Without it a layout script cannot reach elevated windows - AutoHotkey says so
  itself in `UX\ui-setup.ahk`, and an interpreter from scoop can never provide
  it. `deploy.ps1` picks up a `*_UIA.exe` from there automatically.
- **`vcredist2022`**, whose installer calls the Microsoft runtime setup with
  `-RunAs`. That triggers UAC and therefore cannot run over SSH. Most managed
  images ship the runtime already:
  `Get-CimInstance Win32_Product | Where-Object Name -like '*Visual C++ 2015-2022*'`

### B0b. Local, as the working account

```powershell
mkdir "$env:USERPROFILE\.ssh" -Force
notepad "$env:USERPROFILE\.ssh\authorized_keys"      # paste the public key
icacls "$env:USERPROFILE\.ssh\authorized_keys" /inheritance:r /grant "$env:USERNAME:F"
```

`administrators_authorized_keys` is only for admin accounts. A standard user
uses the ordinary per user file.

Check the server before walking away:

```powershell
Get-Service *ssh* | Format-Table Name,Status,StartType
Get-NetTCPConnection -LocalPort 22 -State Listen
Test-NetConnection localhost -Port 22
Get-NetConnectionProfile | Format-Table Name,NetworkCategory
```

The firewall rule must cover the profile the machine is actually in - in a
company network that is usually the domain profile.

### B1. Over SSH, as the working account

Everything below runs without admin rights. That is deliberate: scoop, the WSL
registration, the symlinks and the registry entries all belong to the profile
you work in, and an elevated session would write them into the admin's profile
instead.

```powershell
$ErrorActionPreference = 'Stop'
function Assert-Ok($what) { if ($LASTEXITCODE -ne 0) { throw "$what failed (exit $LASTEXITCODE)" } }

# 0) preconditions
if (-not (Test-Path D:\scoop))                { throw "D:\scoop missing - wrong drive letter?" }
if (-not (Test-Path D:\Github\dotfiles))      { throw "D:\Github\dotfiles missing" }
if (-not (Test-Path D:\wsl-ubuntu-24.04.tar)) { throw "WSL export missing" }
"user: $env:USERNAME"

# 1) register scoop again - no reinstall, the whole tree came with the disk
[Environment]::SetEnvironmentVariable('SCOOP','D:\scoop','User')
$env:SCOOP = 'D:\scoop'
$userPath = [Environment]::GetEnvironmentVariable('PATH','User')
if ($userPath -notlike '*D:\scoop\shims*') {
    [Environment]::SetEnvironmentVariable('PATH', "D:\scoop\shims;$userPath", 'User')
}
$env:PATH = "D:\scoop\shims;$env:PATH"
scoop --version; Assert-Ok 'scoop --version'

# 2) shims, start menu entries, JAVA_HOME and friends live in the profile
scoop reset *; Assert-Ok 'scoop reset'

# 3) bring the repo up to date
Set-Location D:\Github\dotfiles
git checkout -- .; git pull; Assert-Ok 'git pull'

# 4) symlinks, autohotkey autostart, neovide context menu
.\windows\deploy.ps1 -ImportRegistry

# 5) WSL back in place - the registration is per user
wsl --import Ubuntu-24.04 D:\wsl\Ubuntu-24.04 D:\wsl-ubuntu-24.04.tar --version 2
Assert-Ok 'wsl --import'

# 6) interop, as root so sudo cannot ask for a password
wsl -d Ubuntu-24.04 -u root -e bash -c "printf ':WSLInterop:M::MZ::/init:PF\n' > /usr/lib/binfmt.d/WSLInterop.conf; systemctl restart systemd-binfmt"

# 7) ssh keys of the windows side
New-Item -ItemType Directory -Force "$env:USERPROFILE\.ssh" | Out-Null
Copy-Item D:\transfer\ssh\* "$env:USERPROFILE\.ssh\" -Force

# 8) right click a .docx and convert it to markdown (uses pandoc from scoop)
.\windows\pandoc.ps1
```

`$ErrorActionPreference` does not stop native commands, which is why every
scoop, git and wsl call is followed by `Assert-Ok`.

Before step 3, check `git status` in that clone. A clone that has been sitting
on the old machine tends to carry uncommitted work, and `git checkout -- .`
throws it away.

### B2. Local again, as the working account

1. PowerToys > Backup & Restore > Restore
2. Sign out and back in: only then does the autohotkey autostart run and the
   new PATH reach every program

## Phase C - what to check

| Check | Expected |
|---|---|
| `scoop list` | every app, all four buckets |
| after signing in again | the keyboard layout is active |
| wezterm | starts into WSL |
| nvim | no errors, `<leader>cp` opens the markdown preview |
| `:Lazy clean` once | drops plugins that are no longer in the config |
| right click on a folder | "Open Folder as Neovim Project" |
| right click on a .docx | "Convert to Markdown" |
| `wsl -l -v` | the distribution is there and runs version 2 |

## Why some of this is the way it is

- **The drive letter has to stay `D:`.** Every scoop shim contains an absolute
  path like `D:\Scoop\apps\lazygit\current\lazygit.exe`.
- **`scoop reset *` is not cosmetic.** Shims, start menu entries and the
  variables an app exports (`JAVA_HOME`, python's PATH) are written into the
  user profile, which stays behind on `C:`.
- **Elevation and identity are two different things.** The admin account is a
  separate profile. Running the deploy elevated would put the symlinks, the
  startup entry and the registry keys into that profile instead of yours, and a
  scheduled task with "highest privileges" grants a standard account nothing.
- **A snapshot is a snapshot.** After `wsl --export`, work done inside WSL on
  the old machine is not in the image.
