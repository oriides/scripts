#!/usr/bin/env bash

# Input MKV file
input_file=$1

# Check if the input file is provided
if [ -z "$input_file" ]; then
    echo "Usage: $0 <input_file.mkv>"
    exit 1
fi

# Get the directory of the input file
input_directory=$(dirname "$input_file")

# Get the base name of the input file (without extension)
base_name=$(basename "$input_file" .mkv)

# Get the list of audio stream indices
audio_streams=$(ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$input_file")

# Split the indices into an array
IFS=',' read -r -a stream_indices <<<"$audio_streams"

# Loop through each audio stream index and extract it
for index in "${stream_indices[@]}"; do
    # Get the codec of the audio stream
    codec=$(ffprobe -v error -select_streams a:$((index-1)) -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input_file")

    # Debugging output
    echo "Processing audio stream #$index with codec '$codec'"

    # Determine the output file extension based on the codec
    case $codec in
    aac)
        extension="m4a"
        ;;
    mp3)
        extension="mp3"
        ;;
    opus)
        extension="opus"
        ;;
    vorbis)
        extension="ogg"
        ;;
    flac)
        extension="flac"
        ;;
    *)
        extension="mkv" # Default to mkv if codec is unknown
        ;;
    esac

    # Set the output file name
    output_file="$input_directory/${base_name}_audio_stream_$index.$extension"

    echo "Saving audio stream as '$output_file'"

    # Extract the audio stream
    ffmpeg -hide_banner -loglevel warning -i "$input_file" -map 0:$index -c copy "$output_file"

done
