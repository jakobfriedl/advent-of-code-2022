# Advent of Code 2022

My solutions to problems from AOC 2022, written in Nim.

## Dependencies

Install Nim
```sh
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
```

## Create and run template

```sh
source create.sh <number>
nim c -o:bin/day<number> -d:release -r day<number>.nim
```