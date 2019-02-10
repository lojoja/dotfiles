# dotfiles/bash/program/exiftool.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  if hash exiftool &>/dev/null
  then
    function exifClear() {
      local files=$@
      exiftool -Title= -ObjectName= -Description= -Headline= -ImageDescription= -Subject= -Keywords= -City= -Country= -Rights= -Credit= -Creator= -CreatorTool= -Urgency= -UserComment= -Software= -InstanceID= -DocumentID= -OriginalDocumentID= -HistoryAction= -HistoryInstanceID= -HistoryWhen= -HistorySoftwareAgent= -HistoryChanged= -overwrite_original $files
    }


    function exifClearGPS() {
      local files=$@
      exiftool -GPSAltitude= -GPSLatitude= -GPSLatitudeRef= -GPSLongitude= -GPSLongitudeRef= -overwrite_original $files
    }


    function exifSetDate() {
      local timestamp="$1 $2"
      shift 2
      local files=$@
      exiftool -CreateDate="$timestamp" -DateCreated="$timestamp" -ModifyDate="$timestamp" -overwrite_original $files
    }


    function exifSetMovieDate() {
      local timestamp="$1 $2"
      shift 2
      local files=$@
      exiftool -CreateDate="$timestamp" -DateCreated="$timestamp" -MediaCreateDate="$timestamp" -MediaModifyDate="$timestamp" -ModifyDate="$timestamp" -TrackCreateDate="$timestamp" -TrackModifyDate="$timestamp" -overwrite_original $files
    }
  fi
fi
