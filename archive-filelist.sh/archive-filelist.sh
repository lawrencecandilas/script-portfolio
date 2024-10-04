#!/bin/bash

if [[ "$1" == "" ]]; then
 echo "Missing parameter (please specify volume UUID)."
 exit 1
 fi

VOLUME_NAME="[$1]"

get_and_output_file_info() {
 if [[ -d "$1" ]]; then
  OUT1="[directory]"
  OUT2="[directory]"
 else
  OUT1="`sha224sum "$1" | cut -f 1 -d ' '`"
  OUT2="`/bin/stat --printf='%s' "$1"`"
  fi
 echo "\"$VOLUME_NAME\",\"$OUT1\",\"$OUT2\",\"$1\""
}

# CSV header
echo "\"Volume Name\",\"sha2\",\"size(bytes)\",\"filename\""

# I needed find to execute a function in this script (instead of an external
# command) for each file it finds.
#
# I heavily leveraged aecolley's answer here:
# https://unix.stackexchange.com/questions/50692/executing-user-defined-function-in-a-find-exec-call
#

while IFS= read -d '' -r filename; do
 get_and_output_file_info "${filename}" </dev/null
 done < <(find . -print0)

