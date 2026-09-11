# Links the configs of this repo into their Windows locations, the counterpart
# to "make symlinks" on Linux. Needs Developer Mode or an elevated shell.
# -ImportRegistry also adds the neovide entries to the context menu (elevated).

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

# autohotkey layout at logon
$startup = [Environment]::GetFolderPath('Startup')
$shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path $startup 'layout.lnk'))
$shortcut.TargetPath = "$RepoRoot\keymap\layout.ahk"
$shortcut.WorkingDirectory = "$RepoRoot\keymap"
$shortcut.Save()
Write-Host "startup: $startup\layout.lnk -> $($shortcut.TargetPath)"

if ($ImportRegistry) {
    $neovide = (Get-Command neovide -ErrorAction SilentlyContinue).Source
    if (-not $neovide) {
        throw "neovide is not in PATH, install it first"
    }

    # the checked in .reg carries the path of the old machine, patch it
    $template = Join-Path $PSScriptRoot 'neovideOpenFolder.reg'
    $generated = Join-Path $env:TEMP 'neovideOpenFolder.generated.reg'
    $old = 'C:\\Users\\hanses\\scoop\\apps\\neovide\\current\\neovide.exe'
    (Get-Content $template -Raw).Replace($old, $neovide.Replace('\', '\\')) | Set-Content $generated -Encoding Unicode

    reg import $generated
    Write-Host "registry: neovide entries point to $neovide"
}
