import std/[
    strutils, sequtils,
    algorithm, math,
    sugar
]

const file = "./test.txt"
let lines = readFile(file).strip().splitLines()

var 
    board: seq[string] = @[]
    start: tuple[x: int, y: int] 
    destination: tuple[x: int, y: int] 

for x, l in lines: 
    let y_start = l.find('S')
    let y_dest = l.find('E')
    if y_start >= 0: 
        start = (x, y_start)
    if y_dest >= 0:
        destination = (x, y_dest)

    board.add(l)

proc part_one(): int = 
    echo start
    echo destination

    return 0

proc part_two(): int =
    discard

echo "Part one: ", part_one()
echo "Part two: ", part_two()