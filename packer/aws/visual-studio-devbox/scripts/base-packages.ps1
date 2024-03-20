$ErrorActionPreference = "Stop"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force

# ============================== Chokolatey ==============================
Write-Output "Turning on latest TLS protocols, since SSL was depricated by Microsoft. TLS now required to install PoSh modules."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Value "1" -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Value "1" -Type DWord

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name 7Zip4Powershell

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))

choco feature enable -n allowGlobalConfirmation
choco feature enable -n allowemptychecksumsecure
choco feature disable -n usePackageExitCodes
choco feature disable -n showDownloadProgress

$packages = @(
    "7zip.install"
    "awscli"
    "aws-iam-authenticator"
    # "azure-cli"
    "bind-toolsonly"
    "cmake"
    "cppcheck"
    "curl"
    # "cutter"
    # "dependencies"
    # "docfx"
    "doxygen.install"
    # "drmemory"
    # "du"
    "far"
    # "firefox"
    # "ftpdmin"
    "git"
    "git-lfs"
    # "gitextensions"
    "gitversion.portable"
    # "golang"
    # "googlechrome"
    "gpg4win"
    "gradle"
    # "hxd"
    "jdk8"
    "jq"
    # "kubernetes-cli"
    # "kubernetes-helm"
    # "kubernetes-kompose"
    # "kubernetes-kops"
    "llvm"
    # "lockhunter"
    # "make"
    "maven"
    "nasm"
    "ninja"
    # "nodejs-lts"
    "nssm"
    "nuget.commandline"
    # "nunit-console-runner"
    "openssh"
    "openssl.light"
    "packer"
    # "pandoc"
    # "pmd"
    "python"
    # "reshack"
    # "r"
    # "ruby"
    "strawberryperl"
    # "svn"
    "sysinternals"
    "terraform"
    # "tree"
    "vim"
    "vscode"
    "wget"
    # "windirstat"
    # "wixtoolset"
    # "x64dbg.portable"
    # "yarn"
)

foreach ($package in $packages)
{
    choco install -y -r $package
}

Write-Output "nameserver 8.8.8.8" > $env:SystemRoot\System32\Drivers\etc\resolv.conf
Write-Output "nameserver 77.88.8.8" >> $env:SystemRoot\System32\Drivers\etc\resolv.conf

Install-WindowsFeature NET-Framework-Features
Install-WindowsFeature Net-Framework-Core

Start-Sleep -s 10
