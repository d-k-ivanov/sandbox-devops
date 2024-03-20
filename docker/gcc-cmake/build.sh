#!/usr/bin/env bash

GCC_VERSION=$(head -1 version)
CMAKE_VERSION=$(head -2 version | tail -1)

docker build --rm --tag dkivanov/gcc-cmake:${GCC_VERSION}-${CMAKE_VERSION} .
