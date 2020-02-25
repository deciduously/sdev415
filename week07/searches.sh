#!/bin/sh

# Pass a file as the first arg.  Defaults to `./datebook.txt`

## Set file
FILE=$1
if [ -z $FILE ]; then
    FILE=datebook.txt
fi

# 1. Print all lines containing the string San
echo "1:"
grep -F San $FILE
echo
# 2. Print all lines where the person’s first name starts with J.
echo "2:"
grep -P 'J[[:lower:]]+ [[:upper:]][[:alpha:]]+' $FILE
echo
# 3. Print all lines ending in 700
echo "3:"
grep 700$ $FILE
echo
# 4. Print all lines that don’t contain 834
echo "4:"
grep -Fv 834 $FILE
echo
# 5. Print all lines where birthdays are in December (assume the user does not
# know the details of the file format, assume no colon precedes the month)
echo "5:"
grep -P '12/[[:digit:]]{1,2}/[[:digit:]]{1,2}' $FILE
echo
# 6. Print all lines where the phone number is in the 408 area code
# (same as previous question, assume no colon precedes the area code)
echo "6:"
grep -P '408-[[:digit:]]{3}-[[:digit:]]{4}' $FILE
echo
# 7. Print all lines containing an uppercase letter, followed by four lowercase
# letters, a comma, a space, and one uppercase letter.
echo "7:"
grep -P '[[:upper:]][[:lower:]]{4}, [[:upper:]]' $FILE
echo
# 8. Print lines where the last name begins with K or k.
echo "8:"
grep -P '[[:upper:]][[:lower:]]+ [Kk][[:alpha:]]+' $FILE
echo
# 9. Print lines preceded by a line number where the salary is a six-figure number
echo "9:"
grep -PA1 '[[:digit:]]{6}$' $FILE | grep -v '[[:digit:]]{6}$'
echo
# 10. Print lines containing Lincoln or lincoln (remember that grep is sensitive to case)
echo "10:"
grep -Fi lincoln $FILE
echo
