#!/bin/sh

set -e


if ! [[ `hostname` == tuxedo ]]; then
    echo "Not on tuxedo --> exiting"
    exit 1
fi

echo "=> Updating flake inputs"
nix flake update

echo "=> Updating system"

hostname=ultime-pc

nixos-rebuild switch \
    --verbose \
    --fast \
    --flake .#${hostname} \
    --target-host root@${hostname} \
    --build-host root@${hostname}
