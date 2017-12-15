This docker configuration allows running SMR services without
needing a clone of the source code repository. It is intended
to be used on the live game server.

You must include a `.env` file with the following content:

```
SMR_CONFIG_DIR=/path/to/config/dir
SMR_UPLOAD_DIR=/path/to/upload/dir
```
