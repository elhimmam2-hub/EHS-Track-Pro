# ==============================================================================
# EHS Track Pro — Android APK Build Automation Script
# ==============================================================================

Write-Host "====================================================" -ForegroundColor Green
Write-Host "  EHS Track Pro - Android APK Release Builder" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green

$projectDir = "$PSScriptRoot\ehs_android_app"
Set-Location $projectDir

# 1. Check for Java / JDK
$javaCmd = Get-Command java -ErrorAction SilentlyContinue
if (-not $javaCmd) {
    Write-Host "`n[!] Java Development Kit (JDK 17+) was not found in PATH." -ForegroundColor Yellow
    Write-Host "    You have 3 easy options to build the APK:" -ForegroundColor Cyan
    Write-Host "    1. Android Studio (Recommended):" -ForegroundColor White
    Write-Host "       Open '$projectDir' in Android Studio," -ForegroundColor Gray
    Write-Host "       Click 'Build' -> 'Build Bundle(s) / APK(s)' -> 'Build APK(s)'." -ForegroundColor Gray
    Write-Host "`n    2. Cloud Build (Zero Install):" -ForegroundColor White
    Write-Host "       Push this repo to GitHub; the included GitHub Action (.github/workflows/build-apk.yml)" -ForegroundColor Gray
    Write-Host "       will compile the APK on GitHub servers and give you a direct download link." -ForegroundColor Gray
    Write-Host "`n    3. Install JDK 17 locally via winget:" -ForegroundColor White
    Write-Host "       winget install --id EclipseAdoptium.Temurin.17.JDK -e`n" -ForegroundColor Yellow
    
    $choice = Read-Host "Would you like to install JDK 17 now via winget? (y/n)"
    if ($choice -eq 'y' -or $choice -eq 'Y') {
        winget install --id EclipseAdoptium.Temurin.17.JDK -e
        Write-Host "Please restart your shell and re-run build_apk.ps1" -ForegroundColor Green
    }
    exit
}

Write-Host "[+] Java found: $($javaCmd.Source)" -ForegroundColor Green

# 2. Check Android SDK
$androidHome = $env:ANDROID_HOME
if (-not $androidHome -and (Test-Path "$env:LOCALAPPDATA\Android\Sdk")) {
    $env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk"
    $androidHome = $env:ANDROID_HOME
}

if ($androidHome) {
    Write-Host "[+] Android SDK found at: $androidHome" -ForegroundColor Green
} else {
    Write-Host "[!] ANDROID_HOME not detected. If you have Android Studio installed, ensure the SDK is configured." -ForegroundColor Yellow
}

# 3. Execute Gradle Build
Write-Host "`n[*] Starting APK build..." -ForegroundColor Cyan
if (Test-Path "gradlew.bat") {
    .\gradlew.bat assembleRelease
} else {
    gradle assembleRelease
}

$apkOutput = Get-ChildItem -Path "app\build\outputs\apk" -Recurse -Filter "*.apk" -ErrorAction SilentlyContinue
if ($apkOutput) {
    Write-Host "`n[SUCCESS] APK generated successfully!" -ForegroundColor Green
    $apkOutput | ForEach-Object {
        Write-Host " -> $($_.FullName) ($([math]::Round($_.Length / 1MB, 2)) MB)" -ForegroundColor Yellow
    }
} else {
    Write-Host "`nBuild finished. Check app/build/outputs/apk/ for output." -ForegroundColor Cyan
}
