import std/[strutils, sequtils, sugar]

const file = "./input.txt"
let lines = readFile(file).strip().splitLines()

var 
    minX: int
    maxX: int
    maxY: int
    coords: seq[tuple[xLow, xHigh, yLow, yHigh: int]]

proc printCave(cave: seq[seq[char]]) = 
    for c in cave:
        echo c.join(" ")
    echo "\n"

proc initCave(part2: bool = false): seq[seq[char]] = 
    for l in lines: 
        let line = l.split(" -> ").map(x => x.split(",").map(parseInt)).map(x => (x[0], x[1]))
        for i in 0 ..< line.len - 1:
            let 
                xLow = min(line[i][0], line[i + 1][0])
                xHigh = max(line[i][0], line[i + 1][0])
                yLow = min(line[i][1], line[i + 1][1])
                yHigh = max(line[i][1], line[i + 1][1])
            
            coords.add((xLow, xHigh, yLow, yHigh))

    if part2: 
        let floor = coords.map(x => x.yHigh).max() + 2
        let leftBound = coords.map(x => x.xLow).min() - floor
        let rightBound = coords.map(x => x.xHigh).max() + floor
        coords.add((leftBound, rightBound, floor, floor))

    minX = coords.map(x => x.xLow).min()
    maxX = coords.map(x => x.xHigh).max()
    maxY = coords.map(x => x.yHigh).max()

    for i in 0..maxY:
        result.add(@[])
        for j in 0..(maxX - minX):
            result[i].add('.')

    for c in coords: 
        if c.xLow == c.xHigh: 
            # connect vertically
            for y in c.yLow..c.yHigh:
                result[y][c.xLow - minX] = '#'
        else: 
            # connect horizontally
            for x in c.xLow..c.xHigh:
                result[c.yLow][x - minX] = '#'     
        
proc solve(part2: bool = false): int = 
    var 
        cave = initCave(part2)
        finished = false

    while not finished:  
        var 
            # reset starting position
            startX = 500 - minX
            startY = 0

        while true:
            try:
                # check if air is below
                if cave[startY + 1][startX] == '.':
                    inc startY
                # check if air is to the left
                elif cave[startY + 1][startX - 1] == '.':
                    dec startX
                    inc startY
                # check if air is to the right
                elif cave[startY + 1][startX + 1] == '.':
                    inc startX
                    inc startY
                else:
                    # place sand
                    result += 1
                    cave[startY][startX] = 'o'
                    break
                    
            except IndexDefect:
                if not part2: finished = true
                break
        
        if part2 and startX == 500-minX and startY == 0:
            finished = true

    # printCave(cave)  

echo "Part one: ", solve()
echo "Part two: ", solve(part2 = true)