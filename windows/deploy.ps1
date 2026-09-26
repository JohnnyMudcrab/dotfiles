# Links the configs of this repo into their Windows locations, the counterpart
# to "make symlinks" on Linux. Needs Developer Mode or an elevated shell.
# -ImportRegistry also registers the neovide context menu and outlook: links,
# per user and only for what is installed.

param(
    [switch]$ImportRegistry
)

$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $PSScriptRoot

function New-ConfigLink {
    param(
        [Parameter(Mandatory)][string]$Source,
        [Parameter(Mandatory)][string]$Target
    )

    if (-not (Test-Path $Source)) {
        Write-Warning "not in the repo, skipped: $Source"
        return
    }

    $parent = Split-Path -Parent $Target
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }

    if (Test-Path $Target) {
        $item = Get-Item $Target -Force
        if ($item.LinkType -eq 'SymbolicLink') {
            $item.Delete()
        } else {
            # never throw away what is there, the old machine may hold the newer state
            $backup = "$Target.bak-$(Get-Date -Format yyyyMMdd-HHmmss)"
            Move-Item -Path $Target -Destination $backup
            Write-Host "  kept: $backup"
        }
    }

    New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
    Write-Host "linked: $Target -> $Source"
}

$links = @(
    @{ Source = "$RepoRoot\lazyvim";                Target = "$env:LOCALAPPDATA\nvim" },
    @{ Source = "$RepoRoot\wezterm\_wezterm_windows.lua";   Target = "$HOME\.wezterm.lua" },
    @{ Source = "$RepoRoot\keymap\default.json";    Target = "$env:LOCALAPPDATA\Microsoft\PowerToys\Keyboard Manager\default.json" },
    @{ Source = "$RepoRoot\git\lazygit\config.yml"; Target = "$env:APPDATA\lazygit\config.yml" },
    @{ Source = "$RepoRoot\clang\config.yaml";      Target = "$env:LOCALAPPDATA\clangd\config.yaml" }
)

try {
    foreach ($link in $links) {
        New-ConfigLink -Source $link.Source -Target $link.Target
    }
} catch [System.UnauthorizedAccessException] {
    throw "Cannot create symlinks. Turn on Developer Mode (Settings > System > For developers) or run this elevated."
}

# autohotkey layout at logon. Reaching elevated windows requires UI access, and
# that requires the interpreter to sit under Program Files - AutoHotkey says so
# itself in UX\ui-setup.ahk. An interpreter from scoop can never provide it, so
# an official install is preferred when one is present.
$startup = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startup 'layout.lnk'
$layout = "$RepoRoot\keymap\layout.ahk"

$uia = Get-ChildItem "$env:ProgramFiles\AutoHotkey\v2\*_UIA.exe" -ErrorAction SilentlyContinue |
    Select-Object -First 1
$ahk = if ($uia) { $uia.FullName } else { (Get-Command autohotkey -ErrorAction SilentlyContinue).Source }

if ($ahk) {
    $shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $ahk
    $shortcut.Arguments = """$layout"""
    $shortcut.WorkingDirectory = "$RepoRoot\keymap"
    $shortcut.Save()
    Write-Host "startup: $shortcutPath -> $ahk ""$layout"""
    if (-not $uia) {
        Write-Host "  no UI access interpreter, so elevated windows will not see the remaps"
    }
} else {
    # a shortcut to the bare .ahk would only make windows ask at every logon
    # how to open it
    Write-Warning "autohotkey not found, layout autostart skipped - if install.ps1 just ran, open a new shell and run this again"
}

if ($ImportRegistry) {
    # Everything below goes to HKCU\Software\Classes: per user, no admin rights,
    # and Windows merges it into HKEY_CLASSES_ROOT.

    # neovide context menu. The checked in .reg carries the path of the old
    # machine, so it is patched before the import.
    $neovide = (Get-Command neovide -ErrorAction SilentlyContinue).Source
    if ($neovide) {
        $template = Join-Path $PSScriptRoot 'neovideOpenFolder.reg'
        $generated = Join-Path $env:TEMP 'neovideOpenFolder.generated.reg'
        $old = 'C:\\Users\\hanses\\scoop\\apps\\neovide\\current\\neovide.exe'
        $content = (Get-Content $template -Raw).Replace($old, $neovide.Replace('\', '\\'))
        $content = $content.Replace('[HKEY_CLASSES_ROOT\', '[HKEY_CURRENT_USER\Software\Classes\')
        $content | Set-Content $generated -Encoding Unicode
        reg import $generated
        Write-Host "registry: neovide entries point to $neovide"
    } else {
        Write-Warning "neovide not on PATH, context menu skipped"
    }

    # outlook: links, as written by windows\outlook\MailLink.bas, open the mail
    # they point to
    $outlook = Get-ChildItem "$env:ProgramFiles\Microsoft Office\root\Office*\OUTLOOK.EXE" `
        -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($outlook) {
        # same values as the handler the old machine had under HKLM
        $key = 'HKCU:\Software\Classes\outlook'
        New-Item -Path "$key\shell\open\command" -Force | Out-Null
        New-Item -Path "$key\DefaultIcon" -Force | Out-Null
        Set-ItemProperty -Path $key -Name '(Default)' -Value 'URL:Outlook Protocol'
        Set-ItemProperty -Path $key -Name 'URL Protocol' -Value ''
        Set-ItemProperty -Path $key -Name 'EditFlags' -Value 2 -Type DWord
        Set-ItemProperty -Path "$key\DefaultIcon" -Name '(Default)' -Value "$($outlook.FullName),0"
        Set-ItemProperty -Path "$key\shell" -Name '(Default)' -Value 'open'
        Set-ItemProperty -Path "$key\shell\open" -Name '(Default)' -Value 'Open'
        Set-ItemProperty -Path "$key\shell\open\command" -Name '(Default)' `
            -Value """$($outlook.FullName)"" /select ""%1"""
        Write-Host "registry: outlook: links open in $($outlook.FullName)"
    } else {
        Write-Warning "OUTLOOK.EXE not found, outlook: links are not registered"
    }
}
