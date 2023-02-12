#!/bin/sh

set -e


if ! [[ `hostname` == tuxedo ]]; then
    echo "Not on tuxedo --> exiting"
    exit 1
fi

echo "=> Updating flake inputs"
nix flake update

echo "=> Updating system"

hostname=gaming

nixos-rebuild switch \
    --verbose \
    --fast \
    --flake .#ultime-pc \
    --target-host root@${hostname} \
    --build-host root@${hostname}
