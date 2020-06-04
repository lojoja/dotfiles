# dotfiles/bash/program/exiftool.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  if hash exiftool &>/dev/null
  then
    function exifClear() {
      local files=$@
      exiftool -xmp:all= -tagsfromfile @ -xmp:all -Caption-Abstract= -City= -Country= -Creator= -CreatorTool= -Credit= -DerivedFromDocumentID= -DerivedFromInstanceID= -DerivedFromOriginalDocumentID= -Description= -DocumentAncestors= -DocumentID= -GPSDateStamp= -Headline= -HistoryAction= -HistoryChanged= -HistoryInstanceID= -HistoryParameters= -HistorySoftwareAgent= -HistoryWhen= -ImageDescription= -InstanceID= -Keywords= -ObjectName= -OriginalDocumentID= -Rights= -Software= -Subject= -Title= -Urgency= -UserComment= -overwrite_original $files
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


    function exifSetGPS() {
      local lat="$1"
      local lon="$2"
      shift 2
      local files=$@
      local lat_ref=$([[ ${lat::1} == '-' ]] && printf "S" || printf "N")
      local lon_ref=$([[ ${lon::1} == '-' ]] && printf "W" || printf "E")
      exiftool -GPSAltitude=0 -GPSLatitude="$lat" -GPSLatitudeRef="$lat_ref" -GPSLongitude="$lon" -GPSLongitudeRef="$lon_ref" -overwrite_original $files
    }


    function exifSetMovieDate() {
      local timestamp="$1 $2"
      shift 2
      local files=$@
      exiftool -CreateDate="$timestamp" -DateCreated="$timestamp" -MediaCreateDate="$timestamp" -MediaModifyDate="$timestamp" -ModifyDate="$timestamp" -TrackCreateDate="$timestamp" -TrackModifyDate="$timestamp" -overwrite_original $files
    }
  fi
fi
