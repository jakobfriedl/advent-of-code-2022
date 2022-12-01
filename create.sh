#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 day"
    exit 1
fi

name="day$(printf %02d $1)"

mkdir $name
cp template.nim $name/$name.nim
touch $name/test.txt
curl -b session=$(cat .aocrc) "https://adventofcode.com/2022/day/$1/input" > $name/input.txt

cd $name