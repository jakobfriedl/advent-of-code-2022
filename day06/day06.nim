import std/[strutils, sets]

const file = "./input.txt"
let stream = readFile(file).splitLines()[0]

proc first_marker(length: int): int = 
    for i in 0 ..< stream.len-(length-1):
        let packet = stream.substr(i, i+(length-1))
        if packet.toHashSet.len >= length:
            return i+length

proc part_one(): int = 
    first_marker(4)

proc part_two(): int =
    first_marker(14)

echo "Part one: ", part_one()
echo "Part two: ", part_two()