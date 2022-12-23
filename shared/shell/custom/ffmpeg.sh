# dotfiles/shared/shell/custom/ffmpeg.sh
# shellcheck shell=bash

if hash ffmpeg &>/dev/null
then
  function ffmpegSetMovieGPS() {
    local lat="$1"
    local lon="$2"
    local file="$3"
    local extension="${file##*.}"
    local filename="${file%.*}"
    local ll="${lat}${lon}"
    ffmpeg -i "$file" -metadata location="${ll}" -metadata location-eng="${ll}" -codec copy "${filename}_tagged.${extension}"
  }
fi
