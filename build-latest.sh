#!/bin/bash

LATEST_VERSION=`curl -sSfL 'http://releases-cdn.verysync.com/releases/' | grep -P -o '(?<=href=")(v\d+\.\d+\.\d+)(?=/">\1/)' | tail -n 1`

echo 1>&2 Latest Version: ${LATEST_VERSION}

ARCH=amd64

if command -v podman >/dev/null 2>&1;
then
	cmd=podman
else
    cmd=docker
fi

$cmd build \
    --build-arg "TARGET_VERSION=${LATEST_VERSION}" \
    --build-arg "TARGET_PLATFORM_OS=linux" \
    --build-arg "TARGET_PLATFORM_ARCH=${ARCH}" \
    -t zbinlin/verysync .
