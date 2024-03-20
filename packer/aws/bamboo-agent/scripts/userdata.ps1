<powershell>

$InterfaceInfo  = Get-NetConnectionProfile

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

Write-Output "Running User Data Script"
Write-Host "(host) Running User Data Script"

# Supress network location Prompt
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force | Out-Null

# TimeZone
Write-Output "Setting TZ"
tzutil /s \"UTC\"

# Firewall settings
New-NetFirewallRule -DisplayName "Allow-WinRM-5985-TCP" -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Allow
Set-NetConnectionProfile -InterfaceIndex $InterfaceInfo.InterfaceIndex -NetworkCategory Private

# WinRM settings
Start-Service WinRM
Set-Service WinRM -StartupType Automatic

winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="30"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="25"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'

# User
net localgroup administrators bamboo /add

Write-Output "Finished"

</powershell>
