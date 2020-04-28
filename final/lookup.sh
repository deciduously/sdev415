#!/usr/bin/env bash
set -euxo pipefail

# a.
# lookup-1.sh
# SDEV 415 Final Project
# Display a datafile in sorted order as well as the total number of entries
# Ben Lovy
# April 28, 2020

data=datafile

#b. Sort "datafile" by last names.

sort -k2 -t':' "$data" >| "$data".out
mv "$data".out "$data"
rm -f "$data".out

#c. Show the user the contents of "datafile".

cat "$data"

#d. Tell the user the number of entries in the file.

echo "Total entries: `wc -l < $data`"
