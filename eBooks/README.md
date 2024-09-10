# De-DRM eBooks by converting `.acsm` to `.epub`

## Requirements

+ docker (or podman with docker alias)

## Usage

It's recommended to move the script to the directory you keep your eBooks in.
Your credentials, used to decrypt the `.acsm` files, are stored in the same
directory as the script, so it's easy to back them up along with your book
collection.

The script requires write access to the directory where it is stored, so
**do not** place it in a system directory (e.g. `/usr/local/bin`).

```bash
./de-drm <acsm-file> [<path-to-adept-credentials>]
```
