#!/usr/bin/env bash

# checking.sh
# Verify that the passed user is listed in /etc/passwd
# Ben Lovy
# 02 April 2020

if [ $# -ne 1 ]; then
    echo "You must pass a user to look up and nothing else!"
    exit 1
fi

echo "Looking for $1..."
user=`grep ^$1: /etc/passwd`
if [ -z "$user" ]; then
    echo "No such user on our system."
    exit 2
else
    echo "Found $1 in the /etc/passwd file."
    exit 0
fi