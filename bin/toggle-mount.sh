#!/bin/bash

VOLUME="/Volumes/Mac OS X"
DEVICE="/dev/disk1s2"

# TODO: use device name instead, extract mount point fom awk somehow
# mount |grep disk1s2|gawk '{r = gensub(/\((.*)\)/, "Here: \\1", "g", $0);print r}'

# Kill processes using the volume
function quitProcesses {
  PIDS=`lsof |grep "$VOLUME" | awk '$1 != "Finder" {print $2}' | xargs`;
  if [ "`echo $PIDS | wc -c`" -gt "1" ]; then
    kill $PIDS
  fi
}

function unmount {
  diskutil umount "$VOLUME"
  diskutil eject "/dev/disk1"
}
function mount {
  diskutil mount "$DEVICE"
}

if [ "$1" == "unmount" ]; then
  quitProcesses
  unmount
elif [ "$1" == "mount" ]; then
  mount
fi
