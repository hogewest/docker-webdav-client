FROM alpine:latest

ENV WEBDAV_URL= \
    WEBDAV_USERNAME= \
    WEBDAV_PASSWORD= \
    WEBDAV_DIR=/mnt/webdav \
    SYNC_DIR=/share/radio \
    CONF_CRON=/share/conf/crontab \
    CONF_MSMTP=/share/conf/msmtprc

COPY sync.sh /usr/local/bin
COPY entrypoint.sh /usr/local/bin
COPY run.sh /usr/local/bin

RUN apk --no-cache add davfs2 rsync tzdata msmtp perl && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata && \
    chmod u+x /usr/local/bin/entrypoint.sh && \
    chmod u+x /usr/local/bin/run.sh && \
    chmod u+x /usr/local/bin/sync.sh && \
    ln -sf /usr/bin/msmtp /usr/sbin/sendmail && \
    mkdir -p $WEBDAV_DIR

ENTRYPOINT ["entrypoint.sh"]
CMD ["run.sh"]
