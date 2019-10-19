#!/bin/bash

# https://github.com/google/woff2
PATH_TO_WOFF2_DECOMPRESS=~/code/woff2/woff2_decompress

if [ $# -eq 0 ]; then
	cat <<EOL
Usage:
  Save base64 font from website into file (Chromium > Network Panel > Font > Right Click Font > Copy Response)"
		
  $0 file
EOL
	exit 1
fi

DIRECTORY=$(dirname "$1")
BNAME=$(basename "$1" | cut -d. -f1)
WOFF_FILE="$DIRECTORY/$BNAME.woff2"

echo Input file: $1

sed -i -e 's/data:application\/octet-stream;base64,//g' "$1"
base64 -d "$1" > "$WOFF_FILE"

$($PATH_TO_WOFF2_DECOMPRESS "$WOFF_FILE")

rm "$WOFF_FILE"

echo "Should have created $DIRECTORY/$BNAME.ttf"
