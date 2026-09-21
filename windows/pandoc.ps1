# PowerShell Script to set up Pandoc Context Menu Integration
# Registers a 'Convert to Markdown' entry for .docx files. No admin rights needed.

# Variables
$pandocDir = "$env:USERPROFILE\.pandoc"
$pandocConfigPath = "$pandocDir\docx_to_md.yaml"
$converterScriptPath = "$pandocDir\convert_to_markdown.bat"

# Create .pandoc directory if it doesn't exist
if (!(Test-Path $pandocDir)) {
    New-Item -ItemType Directory -Path $pandocDir -Force | Out-Null
    Write-Host "Created directory: $pandocDir" -ForegroundColor Yellow
}

# 1. Create the Pandoc configuration file
$pandocConfig = @"
from: docx
to: markdown-simple_tables-multiline_tables-grid_tables+pipe_tables
standalone: true
wrap: none
markdown-headings: atx
columns: 120
"@

# Save the Pandoc configuration file
Set-Content -Path $pandocConfigPath -Value $pandocConfig

# 2. Create the batch file to handle the conversion
$batchScript = @"
@echo off
:: Batch file to convert DOCX to Markdown using Pandoc
:: The output filename will be the same as the input with .md extension

set INPUT_FILE=%~1
set OUTPUT_FILE=%~dpn1.md
set CONFIG_FILE=%USERPROFILE%\.pandoc\docx_to_md.yaml

echo Converting %INPUT_FILE% to Markdown...
echo Using configuration from: %CONFIG_FILE%

:: Perform the conversion
pandoc "%INPUT_FILE%" -o "%OUTPUT_FILE%" --defaults="%CONFIG_FILE%"

:: Check if conversion was successful
if %ERRORLEVEL% EQU 0 (
    echo.
    echo Conversion successful!
    echo Output saved to: %OUTPUT_FILE%
) else (
    echo.
    echo Conversion failed with error code: %ERRORLEVEL%
    echo Please check if Pandoc is installed correctly and the configuration is valid.
)

echo.
echo Press any key to close this window...
pause > nul
"@

# Save the batch script
Set-Content -Path $converterScriptPath -Value $batchScript -Encoding ASCII

# 3. Add to Windows Context Menu via Registry
# Per user under HKCU\Software\Classes, which Windows merges into HKEY_CLASSES_ROOT.
# Writing to HKCR directly would need admin rights and would land in the admin's
# profile on machines where the working account is a standard user.
$registryPath = "HKCU:\Software\Classes\SystemFileAssociations\.docx\shell\ConvertToMarkdown"

# Create registry keys
New-Item -Path $registryPath -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "MUIVerb" -Value "Convert to Markdown" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "Icon" -Value "shell32.dll,70" -PropertyType String -Force | Out-Null

# Create command key
$commandPath = "$registryPath\command"
New-Item -Path $commandPath -Force | Out-Null
New-ItemProperty -Path $commandPath -Name "(Default)" -Value "`"$converterScriptPath`" `"%1`"" -PropertyType String -Force | Out-Null

# Provide feedback
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "You can now right-click on .docx files and select 'Convert to Markdown'" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:" -ForegroundColor Yellow
Write-Host "- Pandoc configuration: $pandocConfigPath" -ForegroundColor Yellow
Write-Host "- Converter script: $converterScriptPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Note: Make sure Pandoc is installed and available in your PATH" -ForegroundColor Red
Write-Host "To install Pandoc, visit: https://pandoc.org/installing.html" -ForegroundColor Red