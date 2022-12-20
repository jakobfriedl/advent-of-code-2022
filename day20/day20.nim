import std/[
    strutils, sequtils, deques,
    algorithm, math,
    sugar
]

const file = "./input.txt"
let values = readFile(file).strip().splitLines().map(parseInt)

var ordered: seq[tuple[i, v: int]]

proc getNth(values: var seq[tuple[i, v: int]], n: int): int = 
    while values[0][1] != 0:
        values.rotateLeft(1)

    return values[n mod values.len][1]

for i, v in values:
    ordered.add((i, v))

proc part_one(): int =    
    var length = ordered.len

    for i in 0..<ordered.len:
        while ordered[0][0] != i:
            ordered.rotateLeft(1)

        let current = ordered[0]
        ordered.delete(0)
        ordered.rotateLeft(current[1] mod (length-1))
        ordered.add(current)

    result = sum([1000, 2000, 3000].map(x => ordered.getNth(x)))

proc part_two(): int =
    const KEY = 811589153

    discard

echo "Part one: ", part_one() # very bad runtime
echo "Part two: ", part_two()