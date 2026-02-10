param (
    [string]$ContainerName,
    [string]$LicenseFile
)

# Pedir valores si no se pasaron como parámetros
if (-not $ContainerName) {
    $ContainerName = Read-Host "Enter the container name"
}

if (-not $LicenseFile) {
    $LicenseFile = Read-Host "Enter the path to the license file"
}

# Comprobación básica de existencia del archivo
if (-not (Test-Path $LicenseFile)) {
    Write-Error "License file not found: $LicenseFile"
    exit 1
}

Write-Host "Importing license into container '$ContainerName'..." -ForegroundColor Cyan

Import-BcContainerLicense `
    -containerName $ContainerName `
    -licenseFile $LicenseFile `
    -restart

Write-Host "Restarting container '$ContainerName'..." -ForegroundColor Yellow
Restart-BcContainer -containerName $ContainerName

Write-Host "License imported successfully." -ForegroundColor Green
