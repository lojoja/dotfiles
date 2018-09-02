# dotfiles/bash/utils.sh

alias edit="$EDITOR"

lojojaExtractParentDirectory() {
  # Extract a file a ensure the contents is contained in a parent directory.
  local file="$1"
  local count=0
  local create_parent=0

  local tmpdir=$(mktemp -d "$([[ $TMPDIR == '' ]] && printf '/tmp' || realpath "$TMPDIR")/lojojaDotfilesExtract.XXXXXXXXX")
  local filepath=$(dirname "${file}")
  local filename=$(basename "${file}")
  local extract_dir="${filename%%.*}"
  local content_name=''

  case $filename in
    *.7z)
        7z x -o "$tmpdir" "$file" > /dev/null
      ;;
    *.rar)
        unrar e "$file" "$tmpdir" > /dev/null
      ;;
    *.zip)
        unzip -q -d "$tmpdir" "$file"
      ;;
  esac

  rm -rf "${tmpdir}/.DS_Store"
  rm -rf "${tmpdir}/__MACOSX"

  count=$(find "$tmpdir" -maxdepth 1 ! -path "$tmpdir" | wc -l)

  if [[ $count -gt 1 ]]
  then
    create_parent=1
  else
    for item in "$tmpdir"/*
    do
      if [[ -f $item ]] || [[ -d $item && $(basename $item) != $extract_dir ]]
      then
        create_parent=1
      fi
    done
  fi

  if [[ $create_parent -eq 1 ]]
  then
    mkdir "${filepath}/${extract_dir}"
    mv "$tmpdir"/* "${filepath}/${extract_dir}/"
  else
    mv "${tmpdir}/${extract_dir}" "${filepath}/"
  fi

  rm -r "$tmpdir"
}

extract () {
  # Detect and extract common compression formats.
  local file=$1

  if [[ -f $file ]]; then
    case $file in
      *.tar.bz2)  tar xjf "$file"    ;;
      *.tar.gz)   tar xzf "$file"    ;;
      *.7z)       lojojaExtractParentDirectory "$file" ;;
      *.bz2)      bunzip2 "$file"    ;;
      *.gz)       gunzip "$file"     ;;
      *.pkg)      xar -xvf "$file"   ;;
      *.rar)      lojojaExtractParentDirectory "$file" ;;
      *.tar)      tar xf "$file"     ;;
      *.tbz2)     tar xjf "$file"    ;;
      *.tgz)      tar xzf "$file"    ;;
      *.xar)      xar -xvf "$file"   ;;
      *.xz)       tar xJf "$file"    ;;
      *.Z)        uncompress "$file" ;;
      *.zip)      lojojaExtractParentDirectory "$file" ;;
      *)
        printf "${RED_BOLD}Error:${RESET} Unknown format, unable to extract '$file'\n" "$file"
        return 1
        ;;
    esac
  else
    printf "${RED_BOLD}Error:${RESET} '%s' is not a file\n" "$file"
    return 1
  fi
}

function show() {
  # Show contents of a given file or directory.
  local target=$1

  if [[ -r $target ]]
  then
    if [[ -f $target ]]
    then
      less -M "$target"
    else
      ls -Fhl --color=auto "$target"
    fi
  else
    printf "${RED_BOLD}Error:${RESET} Unable to show %s\n" "$target"
    return 1
  fi
}
