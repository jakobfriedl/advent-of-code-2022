import std/[
    strutils, sequtils, tables,
    algorithm, math,
    sugar
]

const file = "./test.txt"
let line = readFile(file).strip()

var 
    shape = {
        0: @[(4, 2), (4, 3), (4,4), (4,5)],
        1: @[(6, 3), (5, 2), (5, 3), (5, 4), (4, 3)],
        2: @[(6, 4), (5, 4), (4, 2), (4, 3), (4, 4)],
        3: @[(7, 2), (6, 2), (5, 2), (4, 2)],
        4: @[(5, 2), (5, 3), (4, 2), (4, 3)]
    }.toTable

    floor = 0

proc part_one(): int = 
    var rock = 0

    while rock < 5:
        var startingShape = shape[rock mod 5].map((x => (x[0] + floor, x[1])))

        echo startingShape

        for jet in line:
            if jet == '<': 
                for i in 0..<startingShape.len:
                    if startingShape[i][1] > 0:
                        startingShape[i] = (startingShape[i][0], startingShape[i][1] - 1)            
                    startingShape[i] = (startingShape[i][0] - 1, startingShape[i][1])            

            elif jet == '>':  
                for i in 0 ..< startingShape.len:
                    if startingShape[i][1] < 6:
                        startingShape[i] = (startingShape[i][0], startingShape[i][1] + 1)
                    startingShape[i] = (startingShape[i][0] - 1, startingShape[i][1])

            let min = startingShape.map(x => x[0]).min() 
            let max = startingShape.map(x => x[0]).max()

            if min == floor: 
                floor += max + 1
                break
        

        echo "End position: ", startingShape
        inc rock

proc part_two(): int =
    discard

echo "Part one: ", part_one()
echo "Part two: ", part_two()