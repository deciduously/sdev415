#!/usr/bin/env bash

# nosy.sh
# Prompt the user for their full name and a login name,
# then display information about the user and the current day and time.
# Ben Lovy
# 02 April 2020

# a
echo -n "Please enter your first name: "
read first
echo -n "Please enter your middle name: "
read middle
echo -n "Please enter your last name: "
read last

# b
echo "Hello, $first!"

# c

# Pass in username to look up followed by sed search string
function search_user_info {
    grep ^$1: /etc/passwd | sed $2
}

echo -n "Please enter your login name: "
read login

echo -n "Your UID is: "
search_user_info $login 's/^[^:]*:[^:]*:\([^:]*\):.*/\1/'

# d
echo -n "Your home directory is: "
search_user_info $login 's/.*:\([^:]*\):[^:]*$/\1/'

# e
echo "These are the processes you are current running:"
ps -u $login

# f
echo "The day of the week is `date "+%A"` and the current time is `date "+%r"`."