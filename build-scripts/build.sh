#!/bin/bash

CGO_ENABLED=0
type=$1

if [ "$type" != "client" ] && [ "$type" != "server" ]; then
    echo "Usage: $0 [client|server]"
    exit 1
fi

if [ "$TRAVIS_COMMIT" != "" ]; then
    commit=$(echo "$TRAVIS_COMMIT" | head -c 7);
    branch="$TRAVIS_BRANCH";
    version="$commit ($branch)"
elif [ $(which git) != "" ]; then
    commit=$(git rev-parse HEAD | head -c 7);
    branch=$(git rev-parse --abbrev-ref HEAD);
    version="$commit ($branch) - UNOFFICIAL BUILD"
else
   version="UNOFFICIAL BUILD"
fi

dstArch="$GOARCH"
if [ "$dstArch" = "386" ]; then
    dstArch="i386"
fi

dstName="engarde-$type"
if [ "$GOOS" = "windows" ]; then
    dstName="$dstName.exe"
fi

echo "Building $type for $GOOS $dstArch - ver. $version"
go build -ldflags "-extldflags=-static -X 'main.Version=$version'" -o dist/$GOOS/$dstArch/$dstName.$GOOS.$dstArch ./cmd/engarde-$type
