RADIO_DIR="$WEBDAV_DIR/$1/"
SYNC_DIR="$SYNC_DIR/$1"

/usr/bin/rsync -avr --inplace --ignore-existing --timeout=10800 --exclude 0_latest $RADIO_DIR $SYNC_DIR > /dev/null
