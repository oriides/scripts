#!/usr/bin/env bash

# The directory containing the film files
BASE_DIRECTORY="path/to/directory"
# The name of the film file (without the extension)
FILM_NAME="Apocalypse Now"

# Constant Rate Factor
# (lower values = better quality = bigger file size)
# ~14 for high quality source to preserve most of the original detail
CRF=14
# Encoding compression preset
# (lower value = better quality compression = longer encode times)
# ~2 if encode speed is not a consideration, otherwise ~5 for decent encode time and decent quality preservation
PRESET=2
# Film Grain Synthesis
# (lower value = less grain = less perceived detail, depending on source)
# ~10 for low grain (e.g. Better Call Saul), ~15 for high grain (e.g. Chernobyl)
GRAIN=12

############################################################

input_file="${BASE_DIRECTORY}/${FILM_NAME}.mkv"
output_file="${BASE_DIRECTORY}/${FILM_NAME} (AV1).mkv"

if [ -f "$input_file" ]; then
  # Run the ffmpeg command to re-encode the video
  echo "reencoding \"${input_file}\" to \"${output_file}\""
  ffmpeg -hide_banner -loglevel warning -i "${input_file}" -map 0 -c:a copy -c:s copy -c:v libsvtav1 -crf $CRF -preset $PRESET -pix_fmt yuv420p10le -svtav1-params tune=0:film-grain=$GRAIN:film-grain-denoise=0 "${output_file}"
fi
