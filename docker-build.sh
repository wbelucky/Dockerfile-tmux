#!/bin/sh
docker build --build-arg BUILD_CONFIG="--enable-sixel" --no-cache --output=bin --target=binaries .
