param
(
    [Parameter(Position = 1, Mandatory = $true)]
    [ValidateSet("build","install", "upgrade", "uninstall", "push")]
    [string] $Operation,

    [Parameter(Position = 2, Mandatory = $true)]
    [ValidateScript({Test-Path $_})]
    [string] $Path
)

$CurrentDirectory   = Split-Path $MyInvocation.MyCommand.Definition
$Path               = Resolve-Path "${Path}"
$PackageName        = Split-Path "${Path}" -Leaf
$NugetSpec          = Join-Path "${Path}" "${PackageName}.nuspec"
[xml] $SpecFile     = Get-Content "${NugetSpec}"
$Version            = $SpecFile.package.metadata.version

# Write-Output $Path
# Write-Output $NugetSpec
# Write-Output $PackageName
# Write-Output $Version
# return

switch ($Operation) {
    "build"
    {
        choco pack ${NugetSpec}
    }
    "install"
    {
        choco pack ${NugetSpec}
        choco install --force --yes --pre --source "${CurrentDirectory};http://chocolatey.org/api/v2/" ${PackageName}
    }
    "upgrade"
    {
        choco pack ${NugetSpec}
        choco upgrade --force --yes --pre --source "${CurrentDirectory};http://chocolatey.org/api/v2/" ${PackageName}
    }
    "uninstall"
    {
        choco uninstall --force --yes ${PackageName}
    }
    "push"
    {
        choco pack ${NugetSpec}
        choco push ${PackageName}.${Version}.nupkg --source https://push.chocolatey.org/
    }
}
