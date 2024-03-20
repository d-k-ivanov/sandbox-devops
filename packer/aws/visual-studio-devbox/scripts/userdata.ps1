<powershell>

$Policy = "Bypass"
$CurrentExecutionPolicy = (Get-ExecutionPolicy)

If ($CurrentExecutionPolicy -ne $Policy -OR $CurrentExecutionPolicy -ne "Unrestricted")
{
    Set-ExecutionPolicy -ExecutionPolicy $Policy -Scope Process -Force
    # Set-ExecutionPolicy -ExecutionPolicy $Policy -Scope LocalMachine -Force
}

Write-Output "Running User Data Script"
Write-Host "(host) Running User Data Script"

# Supress network location Prompt
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force | Out-Null

# TimeZone
Write-Output "Setting TZ"
tzutil /s \"UTC\"

# Firewall settings
New-NetFirewallRule -DisplayName "Allow-WinRM-5985-TCP" -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow-SMB-445-TCP" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Allow

# Set network interface to private
Set-NetConnectionProfile                                                       `
    -InterfaceIndex (Get-NetConnectionProfile).InterfaceIndex                  `
    -NetworkCategory Private

# WinRM settings
Set-Item WSMan:\localhost\Service\AllowUnencrypted -Value True
Set-Item WSMan:\localhost\Service\Auth\Basic       -Value True

# Start-Service WinRM
# Set-Service WinRM -StartupType Automatic
# winrm set winrm/config '@{MaxTimeoutms="1800000"}'
# winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
# winrm set winrm/config/winrs '@{MaxShellsPerUser="30"}'
# winrm set winrm/config/winrs '@{MaxProcessesPerShell="25"}'
# winrm set winrm/config/service '@{AllowUnencrypted="true"}'
# winrm set winrm/config/service/auth '@{Basic="true"}'
# winrm set winrm/config/client/auth '@{Basic="true"}'

# winrm quickconfig -q
# winrm set winrm/config '@{MaxTimeoutms="7200000"}'
# winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
# winrm set winrm/config/winrs '@{MaxConcurrentUsers="100"}'
# winrm set winrm/config/winrs '@{MaxProcessesPerShell="25"}'
# winrm set winrm/config/winrs '@{MaxShellsPerUser="30"}'
# winrm set winrm/config/service '@{AllowUnencrypted="true"}'
# winrm set winrm/config/service '@{TrustedHosts="*"}'
# winrm set winrm/config/service/auth '@{Basic="true"}'
# # winrm set winrm/config/service/auth '@{CredSSP="false"}'
# winrm set winrm/config/client '@{TrustedHosts="*"}'
# winrm set winrm/config/client/auth '@{Basic="true"}'

# Restarting WinRM
# Stop-Service winrm
# Set-Service winrm -startuptype "automatic"
# Start-Service winrm

Write-Output "Finished"

</powershell>
