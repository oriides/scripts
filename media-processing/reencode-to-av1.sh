#!/bin/bash

# Directory containing the input files
INPUT_DIR=""
# Directory to save the output files
OUTPUT_DIR=""

# Constant Rate Factor
# (lower values = better quality = bigger file size)
# ~20 for high quality source (1080p) to preserve most of the original detail
CRF=18
# Encoding compression preset
# (lower value = better quality compression = longer encode times)
# ~3 if encode speed is not a consideration, otherwise ~5 for decent encode time and decent quality preservation
PRESET=3
# Film Grain Synthesis
# (lower value = less grain = less perceived detail, depending on source)
# ~10 for low grain (e.g. Better Call Saul), ~20 for high grain (e.g. Breaking Bad)
GRAIN=12 

############################################################

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through each file in the input directory
for input_file in "$INPUT_DIR"/*; do
  # Check if the file is a regular file
  if [ -f "$input_file" ]; then
    # Get the base name of the file (without directory)
    base_name=$(basename "$input_file")

    # Define the output file path
    output_file="$OUTPUT_DIR/$base_name"

    # Run the ffmpeg command to re-encode the video
    echo "reencoding \"${input_file}\" to \"${output_file}\""
    ffmpeg -i "${input_file}" -map 0 -c:a copy -c:s copy -c:v libsvtav1 -crf $CRF -preset $PRESET -pix_fmt yuv420p10le -svtav1-params tune=0:film-grain=$GRAIN:film-grain-denoise=0 "${output_file}"
  fi
done
