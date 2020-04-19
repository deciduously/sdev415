# foods.sh
# Display a food menu and respond to user input
# Benjamin Lovy
# April 19, 2020

#!/usr/bin/env bash

PS3='Please make a selection. '

while true
do
    select food in 'Steak and potatoes' 'Fish and chips' 'Soup and salad'
    do
        case $food in
        'Steak and potatoes')
            echo 'Stick to your ribs'
            echo 'Watch your cholesterol.'
            ;;
        'Fish and chips')
            echo 'British are coming!'
            ;;
        'Soup and salad')
            echo 'Health foods...'
            echo 'Dieting is so boring.'
            ;;
        esac
        echo 'Enjoy your meal.'
    done
done