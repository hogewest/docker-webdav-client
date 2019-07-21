#!/bin/sh -eu
if [ $# -lt 1 ]; then
  exit 1
fi

unmount() {
  /bin/mountpoint -q ${WEBDAV_DIR}
  if [ "$?" -eq 0 ]; then
    umount -l ${WEBDAV_DIR}
    exit $?
  fi
}
trap "unmount" EXIT INT TERM

WEBDAV_CONTENT_DIR="$WEBDAV_DIR/$1/"
SYNC_DIR="$SYNC_DIR/$1"

/bin/mount -t davfs $WEBDAV_URL $WEBDAV_DIR -o uid=0,gid=users,dir_mode=755,file_mode=755
/usr/bin/rsync -avr --inplace --ignore-existing --timeout=10800 --exclude 0_latest $WEBDAV_CONTENT_DIR $SYNC_DIR > /dev/null
