$ErrorActionPreference = 'Stop'
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

# ============================== Chokolatey ==============================
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco feature enable -n allowGlobalConfirmation
choco feature enable -n allowemptychecksumsecure
choco feature disable -n usePackageExitCodes
choco feature disable -n showDownloadProgress

$packages = @(
  '7zip.install'
  'bind-toolsonly'
  'cmake.portable'
  'curl'
  'du'
  'far'
  'ftpdmin'
  'git'
  'git-lfs'
  'gpg4win'
  'jq'
  'llvm'
  'nuget.commandline'
  'nunit-console-runner'
  'nssm'
  'openssh'
  'openssl.light'
  'packer'
  'python'
  'sysinternals'
  'ruby'
  'ruby2.devkit'
  'terraform'
  'visualstudio2017buildtools --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"'
  'vscode'
  'vim'
  'wget'
  'yarn'
)

foreach ($package in $packages) {
  choco install -y -r $package
}

Install-WindowsFeature NET-Framework-Features
Install-WindowsFeature Net-Framework-Core
