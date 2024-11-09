# Media processing helper scripts

## `de-drm-ebook`

De-DRM eBooks by converting `.acsm` to `.epub`

### Requirements

+ docker (or podman with docker alias)

### Usage

> [!TIP]
> It's recommended to move the script to the directory you keep your eBooks in.
> Your credentials, used to decrypt the `.acsm` files, are stored in the same
> directory as the script, so it's easy to back them up along with your book
> collection.

> [!IMPORTANT]
> The script requires write access to the directory where it is stored, so
> **do not** place it in a system directory (e.g. `/usr/local/bin`).

Download `.epub` file from Adobe using the `.acsm` file:

```sh
./de-drm-ebook <acsm-file> [<path-to-adept-credentials>]
```

## `reencode-to-av1.sh`

Batch transcode video files to AV1 using ffmpeg and SVT-AV1

### Requirements

+ ffmpeg (with `libsvtav1` encoder)

### Usage

> [!TIP]
> Since CPU encoding to AV1 takes **a lot** of time it is best to run this on a
> dedicated transcoding server that can run non-stop for a long time at high CPU
> usage. Mount your Video storage to the server, so you can read and write your
> video files to and from this server.

> [!IMPORTANT]
> Update the `INPUT_DIR` and `OUTPUT_DIR` variables in the script, make sure
> they don't point to the same location otherwise ffmpeg will overwrite the
> source file

Modify the encoding settings in the script via the `CRF`, `PRESET` and `GRAIN`
variables to be appropriate for your use case

Trigger the script remotely using ssh:

```sh
ssh <username>@<server-address> "nohup /path/to/reencode-to-av1.sh > /path/to/output.log 2>&1 &"
```

Or locally:

```sh
/path/to/reencode-to-av1.sh
```

</details>
