#!/bin/bash
:'
___________.__                          ______   ________ ________
\_   _____/|  | ___  ________    ______/  __  \ /  _____//  _____/
 |    __)_ |  | \  \/  /\__  \  /  ___/>      </   __  \/   __  \ 
 |        \|  |__>    <  / __ \_\___ \/   --   \  |__\  \  |__\  \
/_______  /|____/__/\_ \(____  /____  >______  /\_____  /\_____  /
        \/            \/     \/     \/       \/       \/       \/ 
-------------------------------------------------------------------
-------------------------------------------------------------------
'

# VARIABLES
POSTS_DIR="~/personal-notes/posts/"


# rsync files
rsync -av --delete $POSTS_DIR content/posts/
# copy about page
cp ~/personal-notes/posts/about.md content/about.md

# build site
hugo -t terminal

# copy images to correct path
BASE_DIR="public/posts"

# Loop through all directories in the base directory
for dir in "$BASE_DIR"/*; do
  # Check if the current item is a directory
  if [[ -d "$dir" ]]; then
    echo "Processing directory: $dir"

    # Find the first subdirectory within the current directory
    FIRST_SUBDIR=$(find "$dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)

    # Check if a subdirectory exists
    if [[ -z "$FIRST_SUBDIR" ]]; then
      echo "No subdirectory found in $dir. Skipping."
      continue
    fi

    echo "First subdirectory: $FIRST_SUBDIR"

    # Loop through all image files in the current directory
    for file in "$dir"/*.{png,jpg,jpeg,gif}; do
      # Check if the current item is a file
      if [[ -f "$file" ]]; then
        # Move the file to the first subdirectory
        mv "$file" "$FIRST_SUBDIR"
        echo "Moved: $file -> $FIRST_SUBDIR"
      fi
    done
  fi
done


# git stuff
git add .
git commit -m "$1"
git push origin master
