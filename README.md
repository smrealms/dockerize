> [!IMPORTANT]
> This repository is archived! It has been replaced by https://github.com/smrealms/smr/.

This docker configuration allows running SMR services without
needing a clone of the source code repository. It is intended
to be used on the live game server.

You must include a `config/env` file with the following content:

```
SMR_CONFIG_DIR=/path/to/config/dir
SMR_UPLOAD_DIR=/path/to/upload/dir
```

For using Let's Encrypt, you need to create an empty file in the traefik
subdirectory as follows:
```
touch traefik/acme.json
chmod 600 traefik/acme.json
```
