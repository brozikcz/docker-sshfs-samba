FROM alpine:latest

RUN apk add --no-cache bash sshfs sshpass samba supervisor && \
    ln -s /config /root/.ssh

# USER nobody

COPY ./entrypoint.sh /entrypoint.sh
COPY *.conf /config/

RUN mkdir /samba-share

RUN chmod -R 777 /samba-share

VOLUME ["/mount", "/config"]

EXPOSE 135/tcp 137/udp 138/udp 139/tcp 445/tcp
EXPOSE 139 445

ENV UID=0 GID=0 PORT=22 IDENTITY_FILE=/config/id_ed25519 SSHPASS=

ENTRYPOINT ["/entrypoint.sh"]
