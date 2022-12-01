import strutils
import algorithm, math

const file = "./input.txt"

let lines = readFile(file).splitLines()

var calories : seq[int]
var sum : int = 0

for l in lines:
    if not l.isEmptyOrWhitespace:
        sum += l.parseInt
    else:
        calories.add(sum)
        sum = 0

sort(calories, Descending)

echo calories[0]
echo sum(calories[0..2])

