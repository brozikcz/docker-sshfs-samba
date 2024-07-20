# sshfs for macOS without macfuse using samba as a workaround

## Usage

The following command will mount `root@10.0.0.10:/data` to `~/mnt`:

```bash
mkdir ~/mnt

docker run -it --rm \
    --cap-add SYS_ADMIN \
    --device /dev/fuse \
    --name sshfs \
    -v ~/.ssh/id_rsa:/config/id_rsa:ro \
    -p 139:139 \
    -p 445:445 \
    ghcr.io/brozikcz/sshfs-samba:latest \
    root@10.0.0.10:/data

mount_smbfs //guest@localhost/samba-share ~/mnt

enjoy!
```

## Authentification

### Password auth (discouraged)

Set the remote's password via the `SSHPASS` env var.

```bash
docker run -d --rm \
    --cap-add SYS_ADMIN \
    --device /dev/fuse \
    --name sshfs \
    -v ~/.ssh/id_rsa:/config/id_rsa:ro \
    -p 139:139 \
    -p 445:445 \
    -e SSHPASS=password \
    ghcr.io/brozikcz/sshfs-samba:latest \
    root@10.0.0.10:/data
```


### RSA keys

Use the `IDENTITY_FILE` env variable to set the name of the key. It defaults to
`/config/id_ed25519`. For an RSA key it should be `/config/id_rsa`.


## Options

### Different port

You can use a alternate port by setting the `PORT` env var.

### Compression

TODO: Not implemented yet.

Thank you @pschmitt