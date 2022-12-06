import std/[strutils, sets]

const file = "./input.txt"
let stream = readFile(file).splitLines()[0]

proc firstMarker(length: int): int = 
    for i in 0 ..< stream.len-(length-1):
        let packet = stream.substr(i, i+(length-1))
        if packet.toHashSet.len >= length:
            return i+length

echo "Part one: ", firstMarker(4)
echo "Part two: ", firstMarker(14)