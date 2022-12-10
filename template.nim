import std/[
    strutils, sequtils,
    algorithm, math,
    sugar
]

const file = "./test.txt"
let lines = readFile(file).strip().splitLines()

proc part_one(): int = 
    discard

proc part_two(): int =
    discard

echo "Part one: ", part_one()
echo "Part two: ", part_two()