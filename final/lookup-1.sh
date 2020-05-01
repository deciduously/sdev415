#!/usr/bin/env bash
set -euo pipefail

# a.
# lookup-1.sh
# SDEV 415 Final Project
# Display a datafile in sorted order
# Ben Lovy
# April 28, 2020

data=datafile

function sort_by_last {
    sort -k2 -t':' -o $1 $1
}

#b. Sort "datafile" by last names.

sort_by_last $data

#c. Show the user the contents of "datafile".

cat $data

#d. Tell the user the number of entries in the file.

echo "Total entries: `wc -l < $data`"
