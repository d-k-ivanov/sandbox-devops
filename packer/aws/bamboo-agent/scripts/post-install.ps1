$ErrorActionPreference = 'Stop'
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

# ============================== Set global variables ==============================

# Automatically set:
# [Environment]::SetEnvironmentVariable("GIT_LFS_PATH", "C:\Program Files\Git LFS", "Machine")
# [Environment]::SetEnvironmentVariable("TEMP", "%SystemRoot%\TEMP", "Machine")
# [Environment]::SetEnvironmentVariable("TMP", "%SystemRoot%\TEMP", "Machine")

# Manually set:
[Environment]::SetEnvironmentVariable("QTDIR", "C:\tools\Qt5.11.1\5.11.1\msvc2015", "Machine")
[Environment]::SetEnvironmentVariable("QtMsBuild", "C:\tools\QtMsBuild", "Machine")
[Environment]::SetEnvironmentVariable("QMAKESPEC", "C:\tools\Qt5.11.1\5.11.1\msvc2015\mkspecs\win32-msvc", "Machine")

# WIX - is automatically set
# [Environment]::SetEnvironmentVariable("WIX", "C:\Program Files (x86)\WiX Toolset v3.11\", "Machine")
[Environment]::SetEnvironmentVariable("WixToolPath", "%WIX%", "Machine")
[Environment]::SetEnvironmentVariable("WixTargetsPath", "%WixToolPath%Wix.targets", "Machine")
[Environment]::SetEnvironmentVariable("WixTasksPath", "%WixToolPath%wixtasks.dll", "Machine")
