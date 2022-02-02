#!/bin/bash

# Demonstrate the use of shift and while loops.

# Display the first three paramters.

echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo 

# Loop through all the positional parameters.

while [[ "${#}" -gt 0 ]]
do 
	echo "Number of parameters: ${#}"
	echo "Parameter 1: ${1}"
	echo "Parameter 2: ${2}"
	echo "Parameter 3: ${3}"
echo
shift # positional parameters from $N+1 are renamed to $1
done
