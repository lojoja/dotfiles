# dotfiles/shared/shell/custom/exiftool.sh
# shellcheck shell=bash

export EXIFTOOL_HOME="$DOTFILES_INSTALLED_CONFIG_PATH"

common_tags=(-Caption-Abstract= -City= -Country= -Creator= -CreatorTool= -Credit= -DerivedFromDocumentID=\
 -DerivedFromInstanceID= -DerivedFromOriginalDocumentID= -Description= -DocumentAncestors= -DocumentID=\
 -Headline= -HistoryAction= -HistoryChanged= -HistoryInstanceID= -HistoryParameters= -HistorySoftwareAgent=\
 -HistoryWhen= -ImageDescription= -InstanceID= -Keywords= -ObjectName= -OriginalDocumentID= -Rights= -Software=\
 -Subject= -Title= -Urgency= -UserComment=)
datetime_tags=(-CreateDate= -DateCreated= -DateTimeOriginal= -ModifyDate= -OffsetTime= -OffsetTimeDigitized=\
 -OffsetTimeOriginal=)
gps_tags=(-GPSAltitude= -GPSDateStamp= -GPSLatitude= -GPSLatitudeRef= -GPSLongitude= -GPSLongitudeRef=)
xmp_tags=(-xmp:all= -tagsfromfile @ -xmp:all)

if hash exiftool &>/dev/null
then
  function exifClear() {
    local files=("${@}")
    exiftool "${xmp_tags[@]}" "${common_tags[@]}" -overwrite_original "${files[@]}"
  }


  function exifClearAll() {
    local files=("${@}")
    exiftool "${xmp_tags[@]}" "${common_tags[@]}" "${datetime_tags[@]}" "${gps_tags[@]}" -overwrite_original "${files[@]}"
  }


  function exifClearDate() {
    local files=("${@}")
    exiftool "${datetime_tags[@]}" -overwrite_original "${files[@]}"
  }


  function exifClearGPS() {
    local files=("${@}")
    exiftool "${gps_tags[@]}" -overwrite_original "${files[@]}"
  }


  function exifSetDate() {
    # Example: exifSetDate 2021-01-01 13:45 EST picture.jpg
    local date="${1//-/:}"
    local time="$2"
    local zone="$3"
    shift 3
    local files=("${@}")
    local datetime="${date} ${time}"
    local i=0

    # Check time format
    local time_check="${time//[^:]}";

    if [[ ${#time_check} -ne 1 ]]
    then
      printf "Error: Time format is HH:MM\n" && return 1
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
        printf "Error: Unknown Time Zone%s\n" "$zone" && return 1
    esac

    for f in "${files[@]}"
    do
      printf -v sec ":%02d" $i;
      local date="${datetime}${sec}"
      local date_tags=(-CreateDate="${date}" -DateCreated="${date}" -DateTimeOriginal="${date}" -ModifyDate="${date}")
      local zone_tags=(-OffsetTime="${zone}" -OffsetTimeDigitized="${zone}" -OffsetTimeOriginal="${zone}")
      exiftool -s "${date_tags[@]}" "${zone_tags[@]}" -overwrite_original "$f";
      ((i=i+1));
    done
  }

  function exifSetGPS() {
    local lat="$1"
    local lon="$2"
    shift 2
    local files=("${@}")
    local lat_ref
    local lon_ref

    if [[ ${lat::1} == '-' ]]
    then
      lat_ref="S"
    else
      lat_ref="N"
    fi

    if [[ ${lon::1} == '-' ]]
    then
      lon_ref="W"
    else
      lon_ref="E"
    fi

    exiftool -GPSAltitude=0 -GPSLatitude="$lat" -GPSLatitudeRef="$lat_ref" -GPSLongitude="$lon" -GPSLongitudeRef="$lon_ref" -overwrite_original "${files[@]}"
  }

  function exifSetMovieDate() {
    local ts="$1 $2"
    shift 2
    local files=("${@}")
    exiftool -CreateDate="$ts" -DateCreated="$ts" -MediaCreateDate="$ts" -MediaModifyDate="$ts" -ModifyDate="$ts" -TrackCreateDate="$ts" -TrackModifyDate="$ts" -overwrite_original "${files[@]}"
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
