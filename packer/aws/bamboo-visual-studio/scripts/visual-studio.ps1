$ErrorActionPreference = "Stop"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force

# ============================== VS Build Tools ==============================
choco install -y -r visualstudio2019buildtools --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"
Start-Sleep -s 30

# ============================== VS Build Dependencies ==================================
choco install -y -r dotnet4.6.1
choco install -y -r vcredist2008
choco install -y -r vcredist2010
choco install -y -r vcredist2012
choco install -y -r vcredist2013
choco install -y -r vcredist2015
choco install -y -r vcredist2017
Start-Sleep -s 10
