#!/usr/bin/env bash
# if-elif-else example: check if an integer is positive, negative or zero

if [ $# -eq 0 ]; then
    echo "Usage: $0 <integer>"
    exit 2
fi

re='^-?[0-9]+$'
if ! [[ $1 =~ $re ]]; then
    echo "Error: argument is not an integer"
    exit 2
fi

num=$1

if [ "$num" -gt 0 ]; then
    echo "$num is positive"
elif [ "$num" -lt 0 ]; then
    echo "$num is negative"
else
    echo "$num is zero"
fi