#! /bin/sh

if [ -z "${WEBDAV_URL}" ]; then
    echo "No URL specified"
    exit
fi
if [ -z "${WEBDAV_USERNAME}" ]; then
    echo "No username specified"
    exit
fi
if [ -z "${WEBDAV_PASSWORD}" ]; then
    echo "No password specified"
    exit
fi

cp -f $CONF_CRON /var/spool/cron/crontabs/root
cp -f $CONF_MSMTP /etc/msmtprc

echo "use_locks 0" >> /etc/davfs2/davfs2.conf
echo "$WEBDAV_DIR $WEBDAV_USERNAME $WEBDAV_PASSWORD" >> /etc/davfs2/secrets
unset WEBDAV_PASSWORD

mount -t davfs $WEBDAV_URL $WEBDAV_DIR -o uid=0,gid=users,dir_mode=755,file_mode=755
if [ -n "$(ls -1A $WEBDAV_DIR)" ]; then
    umount -l ${WEBDAV_DIR}
    exec "$@"
else
    echo "Mount failed"
fi
