#!/usr/bin/env pwsh
# Build Windows executable with PyInstaller
# Usage: .\scripts\build_windows.ps1 [version]
# Note: Must be run from the repository root directory

param(
    [string]$Version = "1.0.0"
)

Write-Host "Building CooPad for Windows version $Version" -ForegroundColor Green
Write-Host ""

# Check if main.py exists (verify we're in the right directory)
if (-not (Test-Path "main.py")) {
    Write-Host "ERROR: main.py not found. Please run this script from the repository root directory." -ForegroundColor Red
    Write-Host "Example: .\scripts\build_windows.ps1" -ForegroundColor Yellow
    exit 1
}

# Install dependencies
# Note: Using pygame-ce (Community Edition) which supports Python 3.12+
Write-Host "Installing dependencies..." -ForegroundColor Yellow
pip install pyinstaller pillow pygame-ce vgamepad

# Build executable using spec file
Write-Host "Running PyInstaller with spec file..." -ForegroundColor Yellow
Write-Host "Note: The spec file handles proper bundling of vgamepad DLL files" -ForegroundColor Cyan
pyinstaller --noconfirm coopad.spec

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Build complete!" -ForegroundColor Green
    Write-Host "Executable: dist\coopad.exe" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To create an installer, you can use:" -ForegroundColor Yellow
    Write-Host "- Inno Setup (https://jrsoftware.org/isinfo.php)"
    Write-Host "- NSIS (https://nsis.sourceforge.io/)"
    Write-Host "- WiX Toolset (https://wixtoolset.org/)"
} else {
    Write-Host ""
    Write-Host "Build failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}
