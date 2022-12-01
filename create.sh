#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 day"
    return
fi

if [ $1 -lt 0 ] || [ $1 -gt 25 ]; then
    echo "Day must be between 1 and 25"
    return
fi

name="day$(printf %02d $1)"

mkdir $name
touch $name/test.txt
cp template.nim $name/$name.nim
curl -b session=$(cat .aocrc) "https://adventofcode.com/2022/day/$1/input" > $name/input.txt

cd $name