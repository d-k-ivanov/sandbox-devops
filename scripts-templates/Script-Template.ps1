#requires -version 2
<#
.SYNOPSIS
    <Overview of script>

.DESCRIPTION
    <Brief description of script>

.PARAMETER <ParamOne>
    <Brief description of param one input required. Repeat this attribute if required>

.PARAMETER <ParamTwo>
    <Brief description of param tow input required. Repeat this attribute if required>

.INPUTS
    <Inputs if any, otherwise state None>

.OUTPUTS
    <Outputs if any, otherwise state None>

.NOTES
    Version:        1.0
    Author:         <Name>
    Creation Date:  <Date>
    Purpose/Change: Initial script development

.EXAMPLE
    <Example goes here. Repeat this attribute for more than one example>
#>

[CmdletBinding()]
param
(
    [Parameter(Mandatory = $true)]
    [string] $ParamOne,
    [string] $ParamTwo
)

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

Begin
{
    # ------------------------------------------------------------
    # Local Modules
    # ------------------------------------------------------------
    # $PSModulePathSys  = $Env:PSModulePath
    # $PSModulePathLoc  = Join-Path $PSScriptRoot '.modules'
    # $Env:PSModulePath = ${PSScriptRoot}    + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"
    # $Env:PSModulePath = ${PSModulePathLoc} + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"
    # $Env:PSModulePath = ${PSScriptRoot}    + "$([System.IO.Path]::PathSeparator)${PSModulePathLoc}" + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"

    # ------------------------------------------------------------
    # Init
    # ------------------------------------------------------------
    . "${PSScriptRoot}\Functions.ps1"
    Skip-FirstLines
    ElevateSession
    #Script Version
    [string] $ScriptVersion = "1.0"
    [string] $SessionID     = [System.Guid]::NewGuid()
    [string] $LogFile       = (Join-Path $PSScriptRoot $SessionID'.txt')
    # [string] $LogFile       = (Join-Path $env:Temp $SessionID'.txt')

    # ------------------------------------------------------------
    # Logging
    # ------------------------------------------------------------
    Remove-Item     -Force $LogFile -ErrorAction SilentlyContinue
    Start-Transcript -Path $LogFile -Force
    $StartDateTime = Get-Date
    Write-Host "Script started at $StartDateTime"
    Write-Host "Script version: $ScriptVersion"
} # Begin block

Process
{
    # Code goes here
} # Process block

End
{
    # ------------------------------------------------------------
    # Cleanup
    # ------------------------------------------------------------
    # Uncomment if local modules presented
    # $Env:PSModulePath = $PSModulePathSys
    Write-Host "Script finished at $(Get-date) and took $(((get-date) - $StartDateTime).TotalMinutes) Minutes"
    Stop-Transcript
} # End block
