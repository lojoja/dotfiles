# dotfiles/bash/program/exiftool.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  if hash exiftool &>/dev/null
  then
    function exifClear() {
      local files=$@
      exiftool -xmp:all= -tagsfromfile @ -xmp:all -Caption-Abstract= -City= -Country= -Creator= -CreatorTool= -Credit= -DerivedFromDocumentID= -DerivedFromInstanceID= -DerivedFromOriginalDocumentID= -Description= -DocumentAncestors= -DocumentID= -GPSDateStamp= -Headline= -HistoryAction= -HistoryChanged= -HistoryInstanceID= -HistoryParameters= -HistorySoftwareAgent= -HistoryWhen= -ImageDescription= -InstanceID= -Keywords= -ObjectName= -OriginalDocumentID= -Rights= -Software= -Subject= -Title= -Urgency= -UserComment= -overwrite_original $files
    }


    function exifClearAll() {
      local files=$@
      exiftool -xmp:all= -tagsfromfile @ -xmp:all -Caption-Abstract= -City= -Country= -CreateDate= -Creator= -CreatorTool= -Credit= -DateCreated= -DateTimeOriginal= -DerivedFromDocumentID= -DerivedFromInstanceID= -DerivedFromOriginalDocumentID= -Description= -DocumentAncestors= -DocumentID= -GPSAltitude= -GPSDateStamp= -GPSLatitude= -GPSLatitudeRef= -GPSLongitude= -GPSLongitudeRef= -Headline= -HistoryAction= -HistoryChanged= -HistoryInstanceID= -HistoryParameters= -HistorySoftwareAgent= -HistoryWhen= -ImageDescription= -InstanceID= -Keywords= -ModifyDate= -ObjectName= -OffsetTime= -OffsetTimeDigitized= -OffsetTimeOriginal= -OriginalDocumentID= -Rights= -Software= -Subject= -Title= -Urgency= -UserComment= -overwrite_original $files
    }


    function exifClearDate() {
      local files=$@
      exiftool -CreateDate= -DateCreated= -DateTimeOriginal= -ModifyDate= -OffsetTime= -OffsetTimeDigitized= -OffsetTimeOriginal= -overwrite_original $files
    }


    function exifClearGPS() {
      local files=$@
      exiftool -GPSAltitude= -GPSDateStamp= -GPSLatitude= -GPSLatitudeRef= -GPSLongitude= -GPSLongitudeRef= -overwrite_original $files
    }


    function exifSetDate() {
      # Example: exifSetDate 2021-01-01 13:45 EST picture.jpg
      local date="${1//-/:}"
      local time="$2"
      local zone="$3"
      shift 3
      local files=$@
      local datetime="${date} ${time}"
      local i=0

      # Check time format
      local time_check="${time//[^:]}";

      if [[ ${#time_check} -ne 1 ]]
      then
        printf "${RED_BOLD}Error:${RESET} Time format is HH:MM\n" && return 1
      fi

      case $zone in
        EDT)
          zone="-04:00"
          ;;
        CDT | EST)
          zone="-05:00"
          ;;
        MDT | CST)
          zone="-06:00"
          ;;
        PDT | MST)
          zone="-07:00"
          ;;
        PST)
          zone="-08:00"
          ;;
        *)
          printf "${RED_BOLD}Error:${RESET} Unknown Time Zone%s\n" "$zone" && return 1
      esac

      for f in $files
      do
        printf -v sec ":%02d" $i;
        exiftool -s -CreateDate="${datetime}${sec}" -DateCreated="${datetime}${sec}" -DateTimeOriginal="${datetime}${sec}" -ModifyDate="${datetime}${sec}"  -OffsetTime="${zone}" -OffsetTimeDigitized="${zone}" -OffsetTimeOriginal="${zone}" -overwrite_original "$f";
        ((i=i+1));
      done
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

    function exifSetMovieTitle() {
      local file="$1"
      local name=${file##*/} # remove path
      name="${name%.*}" # remove extension
      exiftool -Title="${name}" -overwrite_original "$file"
    }

    function exifSetMovieTitles() {
      local dir="$1"
      for f in "$dir"/*.mp4
      do
        exifSetMovieTitle "$f"
      done
    }
  fi
fi
