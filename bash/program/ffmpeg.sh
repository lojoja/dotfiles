# dotfiles/bash/program/ffmpeg.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  if hash ffmpeg &>/dev/null
  then
    function ffmpegSetMovieGPS() {
      local lat="$1"
      local lon="$2"
      local file="$3"
      local extension="${file##*.}"
      local filename="${file%.*}"

      ffmpeg -i "$file" -metadata location="${lat}${lon}" -metadata location-eng="${lat}${lon}"-codec copy "${filename}_tagged.${extension}"
    }
  fi
fi
