#!/bin/bash

# run-snapcraft.sh: Refresh Apt's cache and then call Snapcraft.
#
# Needed because the base Ubuntu image has no Apt cache.
#

set -e
apt update
exec /bin/snapcraft "$@"

