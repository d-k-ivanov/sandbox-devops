#!/usr/bin/env bash
BUILDPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
VERSION=$(head -1 version)
docker build \
  --rm \
  --tag dkivanov/xeus-cling:${VERSION} ${BUILDPATH}
