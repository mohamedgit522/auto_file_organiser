#!/bin/bash

echo "Auto File Organiser"
log_file="$HOME/auto-file-organizer/organise.log"
echo "[$(date)] Starting file organization..." >> "$log_file"

# Uses Downloads by default if user doesn't specify a folder
target_dir="${1:-$HOME/Downloads}"

# Maps file extension to folder names
declare -A FILE_TYPES=(
  [jpg]="Images"
  [jpeg]="Images"
  [png]="Images"
  [gif]="Images"
  [bmp]="Images"
  [webp]="Images"
  [heic]="Images"

  [pdf]="Documents"
  [doc]="Documents"
  [docx]="Documents"
  [txt]="Documents"
  [rtf]="Documents"
  [odt]="Documents"
  [csv]="Documents"
  [xlsx]="Documents"
  [xls]="Documents"
  [ppt]="Documents"
  [pptx]="Documents"

  [zip]="Archives"
  [tar]="Archives"
  [gz]="Archives"
  [rar]="Archives"
  [7z]="Archives"

  [mp4]="Videos"
  [mkv]="Videos"
  [mov]="Videos"
  [avi]="Videos"

  [mp3]="Audio"
  [wav]="Audio"
  [m4a]="Audio"
  [ogg]="Audio"
)


# Maps MIME types to folder names
declare -A MIME_TYPES=(
  ["text/plain"]="Documents"
  ["text/csv"]="Documents"
  ["application/pdf"]="Documents"
  ["application/zip"]="Archives"
  ["application/x-rar"]="Archives"
  ["application/x-7z-compressed"]="Archives"

  ["application/vnd.openxmlformats-officedocument.wordprocessingml.document"]="Documents"
  ["application/msword"]="Documents"
  ["application/vnd.ms-excel"]="Documents"
  ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]="Documents"
  ["application/vnd.ms-powerpoint"]="Documents"
  ["application/vnd.openxmlformats-officedocument.presentationml.presentation"]="Documents"

  ["image/jpeg"]="Images"
  ["image/png"]="Images"
  ["image/gif"]="Images"
  ["image/webp"]="Images"
  ["image/bmp"]="Images"
  ["image/heic"]="Images"

  ["video/mp4"]="Videos"
  ["video/quicktime"]="Videos"
  ["video/x-matroska"]="Videos"
  ["video/x-msvideo"]="Videos"

  ["audio/mpeg"]="Audio"
  ["audio/wav"]="Audio"
  ["audio/x-wav"]="Audio"
  ["audio/mp4"]="Audio"
  ["audio/ogg"]="Audio"
)


# Loop through fils in the target directory
for file in "$target_dir"/*; do
  echo "Processing: $file"
  # Skip if  not a regular file
  if [[ ! -f "$file" ]]; then
     continue 
  fi

  filename=$(basename "$file")

  # Try to get extension and match to folder
  if [[ "$filename" == *.* ]]; then
    extension="${filename##*.}"
    extension="${extension,,}"     # Convert extension to lowercase to avoid issues with uppercase
    folder="${FILE_TYPES[$extension]}"
  else
    # No extension, detect file type using MIME
    filetype=$(file --mime-type -b "$file")
    folder="${MIME_TYPES[$filetype]}"
  fi

  # Fallback if no folder found
  if [[ -z "$folder" ]]; then
    folder="Others"
  fi

  # Creates folder and move file
  mkdir -p "$target_dir/$folder"
  echo "Moving '$filename' to folder: $folder"
  mv "$file" "$target_dir/$folder/"
  echo "[$(date)] Moved '$filename' to '$folder'" >> "$log_file"

done

echo "[$(date)] Organizing complete!" >> "$log_file"
echo "Organizing complete!"

