# Bootstraps scoop and installs every app from windows/scoop.json.
# Create that file on the old machine with:  scoop export -c > windows\scoop.json

param(
    [string]$ScoopRoot = 'D:\scoop'
)

$ErrorActionPreference = 'Stop'
$ScoopFile = Join-Path $PSScriptRoot 'scoop.json'

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# scoop export drops root_path on purpose, so the location has to be set here
$env:SCOOP = $ScoopRoot
[Environment]::SetEnvironmentVariable('SCOOP', $ScoopRoot, 'User')

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "scoop is already installed"
} else {
    Write-Host "Installing scoop into $ScoopRoot"
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

# buckets are git clones, so git has to come first
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    scoop install git
}

if (-not (Test-Path $ScoopFile)) {
    throw "$ScoopFile not found. Run 'scoop export -c > windows\scoop.json' on the old machine and commit it."
}

# adds the buckets first, then every app from its bucket, keeping holds
scoop import $ScoopFile

Write-Host ""
Write-Host "Done. Next: .\windows\deploy.ps1  (needs Developer Mode or an elevated shell)"
