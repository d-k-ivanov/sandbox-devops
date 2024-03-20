$ErrorActionPreference = 'Stop'
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

# ============================== Post-Install Scripts ==============================
$updated_path += "C:\Program Files\CMake\bin;"
$updated_path += $Env:Path

[Environment]::SetEnvironmentVariable("PATH", "$updated_path", "Machine")
