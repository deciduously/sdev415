# mchecker.sh
# Check for new mail every thirty seconds and display a message if found
# Benjamin Lovy
# April 19, 2020

#!/usr/bin/env bash

period=30

# Function to grap file size
function get_size {
    # Use space-delimited fields, snag only the first field
    wc -c $1 | cut -d " " -f 1
}

user=`whoami`

spool="/var/spool/mail/$user"
last_size=`get_size $spool`

# Loop forever
while true
do
    new_size=`get_size $spool`
    if [ "$new_size" -gt "$last_size" ]
    then
        echo "$user, you have new mail!"
    fi
    last_size=$new_size
    sleep $period
done
