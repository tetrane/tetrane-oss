#!/bin/bash

BASEDIR="$(realpath "$(dirname "$0")")"

if [ -z "${MAIN_SCRIPT+x}" ]; then
    export MAIN_SCRIPT=1
fi

source $BASEDIR/bochs/DEPENDENCIES_DEV.sh
source $BASEDIR/panda/DEPENDENCIES_DEV.sh
source $BASEDIR/virtualbox/DEPENDENCIES_DEV.sh

# common/rvn*
STRETCH_DEPENDENCIES="$STRETCH_DEPENDENCIES
libboost-all-dev
libmagic-dev
libsqlite3-dev
"


function echo_error() {
    echo -ne '\033[0;31m'
    echo $@
    echo -ne '\033[0m'
}

function run() {
    $@ >/tmp/reven_dependencies.log 2>&1
    exit_code=$?
    if [ "$exit_code" != "0" ]; then
        echo "======================= BEGIN APT LOG ======================="
        cat /tmp/reven_dependencies.log
        echo "=======================  END APT LOG  ======================="
        echo_error -e "\nThere was a problem installing dependencies. Please check-out the logs above."
        exit $exit_code
    fi
}

echo "Updating package list"
run apt update
echo "Installing dependencies. This may take a while."
DEBIAN_VERSION=$(lsb_release -sc)
if [ "$DEBIAN_VERSION" = "stretch" ]; then
    run apt install -y $STRETCH_DEPENDENCIES
elif [ "$DEBIAN_VERSION" = "buster" ]; then
    run apt install -y $BUSTER_DEPENDENCIES
fi
