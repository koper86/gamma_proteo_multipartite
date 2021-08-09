#!/bin/bash
# script to rename files basenames in given directory.
# First argument is dir, second text to add before extension (must have_ and .)

dir=$1
to_add=$2
for fullfile in ${dir}/*; do
  if [ -f "$fullfile" ]; then
    dirname=$(dirname $fullfile)
    filename=$(basename $fullfile)
    extension="${filename##*.}"
    filename_noext="${filename%.*}"
    printf "%s\n" $dirname
    printf "%s\n" $filename
    printf "%s\n" $extension
    printf "%s\n" $filename_noext
    mv "$fullfile" "${dirname}/${filename_noext}${to_add}${extension}"
  fi
done



