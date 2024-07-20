FROM alpine:3.20.1

RUN apk add --no-cache bash sshfs sshpass samba supervisor

RUN ln -s /config /root/.ssh

COPY ./entrypoint.sh /entrypoint.sh
COPY *.conf /config/

RUN mkdir /samba-share

RUN chmod -R 777 /samba-share

VOLUME ["/config"]

EXPOSE 139 445

ENV UID=0 GID=0 PORT=22 IDENTITY_FILE=/config/id_ed25519 SSHPASS=

ENTRYPOINT ["/entrypoint.sh"]
