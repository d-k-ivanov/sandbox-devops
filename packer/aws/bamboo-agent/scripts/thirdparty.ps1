$ErrorActionPreference = 'Stop'
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

# ============================== Thitdparty ==============================
choco install -y -r wixtoolset

Write-Host "Clone third-parties"
ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts
