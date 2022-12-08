import std/[strutils, sequtils, sugar]

const file = "./input.txt"
let lines = readFile(file).splitLines()

proc part_one(): int = 
    # Edge trees are always visible 
    result = (lines.len * 2) + (lines[0].len * 2) - 4
    
    for i, line in lines:
        for j, tree in line:
            # skip edge trees
            if i == lines.low or i == lines.high or j == line.high or j == line.low: continue 

            # check if tree is visible from left
            var visibleLeft: bool = true
            for c in countdown(i-1, 0):
                if lines[c][j] >= tree:
                    visibleLeft = false 
                    break
            
            # check if tree is visible from right
            var visibleRight: bool = true
            for c in countup(i+1, lines.high):
                if lines[c][j] >= tree:
                    visibleRight = false 
                    break

            # check if tree is visible from top
            var visibleTop: bool = true
            for c in countdown(j-1, 0):
                if lines[i][c] >= tree:
                    visibleTop = false 
                    break
            
            # check if tree is visible from bottom
            var visibleBottom: bool = true
            for c in countup(j+1, line.high):
                if lines[i][c] >= tree:
                    visibleBottom = false 
                    break

            # check if tree is visible from any side
            if any([visibleLeft, visibleRight, visibleTop, visibleBottom], x => x == true):
                result += 1

proc part_two(): int =
    for i, line in lines:
        for j, tree in line:
            # skip edge trees
            if i == lines.low or i == lines.high or j == line.high or j == line.low: continue 

            # count until left tree blocks view
            var countLeft: int = 0
            for c in countdown(i-1, 0):
                countLeft += 1
                if lines[c][j] >= tree:
                    break

            # count until right tree blocks view
            var countRight: int = 0
            for c in countup(i+1, lines.high):
                countRight += 1
                if lines[c][j] >= tree:
                    break
            
            # count until top tree blocks view
            var countTop: int = 0
            for c in countdown(j-1, 0):
                countTop += 1
                if lines[i][c] >= tree:
                    break
                    
            # count until bottom tree blocks view
            var countBottom: int = 0
            for c in countup(j+1, line.high):
                countBottom += 1
                if lines[i][c] >= tree:
                    break
            
            let scenicScore = countLeft * countRight * countTop * countBottom
            if scenicScore > result:
                result = scenicScore

echo "Part one: ", part_one()
echo "Part two: ", part_two()