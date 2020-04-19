# add.sh
# Takes two arguments and returns thir sum
# Benjamin Lovy
# April 19, 2020

function add {
    return $(( $1 + $2 ))
}

# Verify proper invocation
if [ "$#" -ne 2 ]
then
    echo "Usage: ./add.sh operandOne operandTwo"
    exit 1
fi

# Provide result
add $1 $2
echo "The sum is $?."
