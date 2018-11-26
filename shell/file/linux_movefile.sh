#!/bin/bash
#For MAC OSX Bash
read -p "Enter the source directory >" BASE_DIR
read -p "Enter the target directory >" target_dir

find "$BASE_DIR" -type f |
 while IFS= read -r file; do
    folder_date=$(stat -f "%SB" -t "%Y-%m-%d" "$file")
    [[ ! -d "$target_dir/$folder_date" ]] && mkdir -p "$target_dir/$folder_date$

## Move the file
    mv "$file" "$target_dir/$folder_date"
done
