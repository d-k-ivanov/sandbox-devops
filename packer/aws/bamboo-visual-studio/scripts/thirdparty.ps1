$ErrorActionPreference = 'Stop'
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

# ============================== Thitdparty ==============================
Write-Host "Install WIN Toolset"
choco install -y -r wixtoolset
# WIX - is automatically set
# [Environment]::SetEnvironmentVariable("WIX", "C:\Program Files (x86)\WiX Toolset v3.11\", "Machine")
[Environment]::SetEnvironmentVariable("WixToolPath", "%WIX%", "Machine")
[Environment]::SetEnvironmentVariable("WixTargetsPath", "%WixToolPath%Wix.targets", "Machine")
[Environment]::SetEnvironmentVariable("WixTasksPath", "%WixToolPath%wixtasks.dll", "Machine")

# Windows 8.1 SDK
c:\tools\distro\win_sdk_8_1_setup.exe /features + /q
