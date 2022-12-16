import std/[
    strutils, sequtils, strscans,
    algorithm, math,
    sugar
]

const file = "./test.txt"
let lines = readFile(file).strip().splitLines()

proc parseInput() = 
    const ROW = 10

    for l in lines:
        let (s, sensorX, sensorY, beaconX, beaconY) = scanTuple(l, "Sensor at x=$i, y=$i: closest beacon is at x=$i, y=$i")
        assert s

        let manhatten = abs(sensorX - beaconX) + abs(sensorY - beaconY)

proc part_one(): int = 
    parseInput()

proc part_two(): int =
    discard

echo "Part one: ", part_one()
echo "Part two: ", part_two()