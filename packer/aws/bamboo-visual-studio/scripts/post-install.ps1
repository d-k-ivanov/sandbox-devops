$ErrorActionPreference = 'Stop'
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

# ============================== Set global variables ==============================

# User
net localgroup administrators bamboo /add

& C:\cygwin\bin\bash.exe -c 'sudo cp -rf /cygdrive/c/Users/Bamboo/{.ssh,.gitconfig} /home/Bamboo'
& C:\cygwin\bin\bash.exe -c 'sudo cp -rf /cygdrive/c/Users/Administrator/{.ssh,.gitconfig} /home/Administrator'
& C:\cygwin\bin\bash.exe -c 'sudo chown -R Bamboo:None /cygdrive/c/cygwin/home/Bamboo'
& C:\cygwin\bin\bash.exe -c 'sudo chown -R Administrator:Users /cygdrive/c/cygwin/home/Administrator'
& C:\cygwin\bin\bash.exe -c 'sudo chmod 600 /cygdrive/c/cygwin/home/Bamboo/.ssh'
& C:\cygwin\bin\bash.exe -c 'sudo chmod 600 /cygdrive/c/cygwin/home/Administrator/.ssh'
