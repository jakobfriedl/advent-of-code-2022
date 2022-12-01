import strutils, sequtils
import algorithm, math
import sugar

const file = "./input.txt"
let lines = readFile(file).split("\n\n")

var calories : seq[int] = lines.map(l => sum(l.splitLines().map(parseInt)))
sort(calories, Descending)

echo "Part one: ", calories[0]
echo "Part two: ", sum(calories[0..2])