import strutils, sequtils, strscans, parseutils, algorithm
import sugar

const file = "./input.txt"
let lines = readFile(file).split("\n\n")

type
    Move = object
        n, frm, to: int
    Stack = array[9, seq[char]]

var 
    stacksPartOne: Stack
    stacksPartTwo: Stack
    moves: seq[Move]

proc parseCrates() = 
    var stacks: Stack
    for l in lines[0].splitLines:
        if l.startsWith(" 1"): 
            break
        var i = 0
        while i < l.len:
            i += l.skipUntil('[', i)
            if i < l.high:
                stacks[i div 4].add(l[i + 1])
            inc i, 2
    stacksPartOne = stacks
    stacksPartTwo = stacks

proc parseMoves() =
    for l in lines[1].splitLines:
        let (success, n, frm, to) = l.scanTuple("move $i from $i to $i")
        if success:
            moves.add(Move(n: n, frm: frm, to: to))

proc move(n: int, frm: int, to: int) = 
    for i in 0..<n:
        stacksPartOne[to-1].add stacksPartOne[frm-1].pop()

proc move_multiple(n: int, frm: int, to: int) = 
    stacksPartTwo[to-1].add stacksPartTwo[frm-1].toOpenArray(stacksPartTwo[frm-1].len - n, stacksPartTwo[frm-1].high)
    stacksPartTwo[frm-1].setLen(stacksPartTwo[frm-1].len - n)

proc solve() = 
    parseCrates() 
    parseMoves()
    
    for stack in stacksPartTwo.mitems:
        stack.reverse()

    for stack in stacksPartOne.mitems:
        stack.reverse()

    for m in moves:
        move(m.n, m.frm, m.to)
        move_multiple(m.n, m.frm, m.to)

    echo "Part one: ", stacksPartOne.filterIt(it.len > 0).map(x => x[^1]).join("")
    echo "Part two: ", stacksPartTwo.filterIt(it.len > 0).map(x => x[^1]).join("")

solve()
