#! /bin/sh

unmount() {
    umount -l ${WEBDAV_DIR}
    echo "Unmounted ${WEBDAV_DIR}"
    exit $?
}

trap "unmount" INT TERM

crond -l 2

while true; do
    sleep 5
done
