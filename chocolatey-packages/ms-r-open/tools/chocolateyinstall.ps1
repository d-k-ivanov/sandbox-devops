$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = "ms-r-open"
    fileType       = "EXE"
    url            = "https://mran.blob.core.windows.net/install/mro/4.0.2/Windows/microsoft-r-open-4.0.2.exe"
    url64bit       = "https://mran.blob.core.windows.net/install/mro/4.0.2/Windows/microsoft-r-open-4.0.2.exe"
    checksum       = "EB4F0DDB009A5CF63A85024599238802E0F4E509BE3A065A3EAED9D185DE66B7"
    checksum64     = "EB4F0DDB009A5CF63A85024599238802E0F4E509BE3A065A3EAED9D185DE66B7"
    checksumType   = "sha256"
    checksumType64 = "sha256"
    silentArgs     = "/quiet"
    validExitCodes = @(0, 1603, 1626)
    softwareName   = "Microsoft-R-Open"
}

Install-ChocolateyPackage @packageArgs
