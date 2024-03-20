#!/usr/bin/env pwsh

$GCC_VERSION    = $(Get-Content version -First 1)
$CMAKE_VERSION  = $(Get-Content version -First 2)[-1]

docker build --rm --tag dkivanov/gcc-cmake:${GCC_VERSION}-${CMAKE_VERSION} .
