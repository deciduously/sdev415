#!/usr/bin/env bash
set -euo pipefail

# lookup-3.sh
# SDEV 415 Final Project
# Menu-driven CLI for a data file
# Ben Lovy
# April 28, 2020

# Data location
data='datafile'
delim=':'

# Helper functions

function sort_by_last {
    sort -k2 -t':' -o $1 $1
}

function add_user {
    echo "Add new user"
    echo
    # Gather info
    echo -n "Enter first name: "
    read first
    echo -n "Enter last name: "
    read last
    echo -n "Enter phone number: "
    read phone
    echo -n "Enter address: "
    read address
    echo -n "Enter birthday: "
    read birthday
    echo -n "Enter salary: "
    read salary

    # Build string
    s="${first}:${last}:${phone}:${address}:${birthday}:${salary}"
    # Insert line
    echo $s >> $data
    echo "Success!  Added new entry for ${first} ${last}."

    # Sort and find which number the entry was
    sort_by_last $data
    grep -Fn "$s" $data
}

function delete_user {
    # Either return the full string or "Invalid entry, try again"
    error_msg="Invalid entry, try again"
    # Look up by first and last name
    echo -n "Enter first name: "
    read query_first

    # If it's empty, return invald
    if grep -q "$query_first[:?]" $data; then
        # If the first name matched, make sure the second name does too
        echo -n "Enter last name: "
        read query_last

        if grep -q "$query_last[:?]" $data; then
            echo "Deleting..."
            sed -i "/$query_first:$query_last/d" $data
        else
            echo "$error_msg"
            exit 1
        fi
    else
        echo "$error_msg"
        exit 1
    fi
}

function view_user {
    # Either return the full string or "Invalid entry, try again"
    error_msg="Invalid entry, try again"
    # Look up by first and last name
    echo -n "Enter first name: "
    read query_first

    # If it's empty, return invald
    if grep -q "$query_first[:?]" $data; then
        # If the first name matched, make sure the second name does too
        echo -n "Enter last name: "
        read query_last
        if grep -q "$query_last[:?]" $data; then
            echo `grep "$query_last[:?]" $data`
        else
            echo "$error_msg"
            exit 1
        fi
    else
        echo "$error_msg"
        exit 1
    fi
}

function sort_and_display {
    echo "Datafile:"
    sort_by_last $data
    cat $data
    echo "Total entries: `wc -l < $data`"
}

function menu {
    PS3="Enter your choice> "
    select option in add delete view quit
    do
        case $option in
            add)
                add_user;;
            delete)
                delete_user;;
            view)
                view_user;;
            quit)
                exit 0;;
        esac
    done
}

# Main routine

sort_and_display
echo
menu
