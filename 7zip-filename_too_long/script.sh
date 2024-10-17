#!/bin/bash

# Remove the below after customizing.
echo "This is an example script that you need to examine and customize for your"
echo "own purposes. If you are reading this you didn't do that yet."
exit 0

# This will be the base directory in which you want to extract the files.
BASE="/basedir/"

# List of files is streamed in through stdin - line at a time.

while read FILENAME; do
 # Truncate file name to 128 characters.
 # This will lob off the extension at the end. We will get that shortly.
 NEWNAME=${FILENAME:0:128}

 # Trim whitespace at beginning and end.
 # In this case, the whitespace may happen at the end.
 # https://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable
 NEWNAME="${NEWNAME%"${NEWNAME##*[![:space:]]}"}"

 # Get rid of some characters that may cause problems.
 NEWNAME=`echo "$NEWNAME" | tr "',;" "___"`

 # Tack on extension we grabbed earlier.
 # * We do this by reversing the string, cutting everything after the first
 # dot, then reversing it back.
 EXT=`echo "$FILENAME" | rev | cut -f 1 -d '.' | rev`

 # Final assembly
 NEWNAME="/x/$NEWNAME.$EXT"

 echo "$NEWNAME"

 echo "processing '$NEWNAME' ..."
 7zz e "/example/bigarchive.7z" -so "$FILENAME" > "$NEWNAME"
 done

