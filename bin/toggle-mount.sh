#!/bin/bash

VOLUME="/Volumes/Storage"
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

function _unmount {
  #diskutil umount "$VOLUME"
  diskutil eject "$DEVICE"
}
function _mount {
  diskutil mount "$DEVICE"
}

# Either use command line arguments..
if [ "$1" == "unmount" ]; then
  _unmount
elif [ "$1" == "mount" ]; then
  _mount
# .. or toggle, i.e. unmount if mounted and vice versa
else
  MOUNTED=$(mount | grep $DEVICE |wc -l)
  if [ "$MOUNTED" -eq "1" ]; then
    _unmount
  else
    _mount
  fi
fi


