param (
    [string]$ContainerName,
    [int]$BCVersion,
    [string]$Country,
    [string]$UserName,
    [string]$Password,
    [string]$LicenseFile
)

# Solicitar información al usuario.
if (-not $ContainerName) {
    $ContainerName = Read-Host "Enter the container name"
}

if (-not $BCVersion) {
    $BCVersion = [int](Read-Host "Enter the BC version")
}

if (-not $Country) {
    $Country = Read-Host "Enter the BC country"
}

if (-not $UserName) {
    $UserName = Read-Host "Enter your username"
}

if (-not $Password) {
    $Password = Read-Host "Enter your password" -AsSecureString
}

# Crear credenciales
$Credential = New-Object pscredential $UserName, (ConvertTo-SecureString -String $Password -AsPlainText -Force)

# Solicitar origen licencia
while (-not $LicenseFile -or -not (Test-Path $LicenseFile)) {
    $LicenseFile = Read-Host "Enter the path to the license file (or leave blank to skip)"
    if (-not $LicenseFile) { break }
}

# Obtener URL del artifact
$ArtifactUrl = Get-BCArtifactUrl -version $BCVersion -country $Country -select Latest

Write-Host "Creating Business Central container '$ContainerName'..." -ForegroundColor Cyan

# Parámetros del contenedor
$Params = @{
    accept_eula = $true
    alwaysPull = $true
    artifactUrl = $ArtifactUrl
    containerName = $ContainerName
    auth = "UserPassword"
    credential = $Credential
    includeAL = $true
    updateHosts = $true
    assignPremiumPlan = $true
    accept_outdated = $true
    useBestContainerOS = $true
    enableTaskScheduler = $false
    includeTestToolkit = $true
}

# Incluir licencia
if ($LicenseFile -and (Test-Path $LicenseFile)) {
    $Params.licenseFile = $LicenseFile
}

# Crear contenedor
New-BCContainer @Params

Write-Host "Container '$ContainerName' created successfully." -ForegroundColor Green
