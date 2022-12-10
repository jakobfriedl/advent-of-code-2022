import std/[strutils, math]

const file = "./input.txt"
let lines = readFile(file).strip().splitLines()

var 
    register = 1
    cycle = 1
    signals: seq[int]
    sprite: seq[int] = @[0, 1, 2]
    crt: string = "#"

proc incCycle() = 
    cycle += 1
    if cycle == 20 or (cycle-20) mod 40 == 0:
        signals.add(register * cycle)

proc drawCycle() = 
    if sprite.contains(cycle mod 40): 
        crt &= "#"
    else: 
        crt &= "."

    if cycle mod 40 == 0:
        echo crt[0 ..< ^1]
        crt = "#"

    cycle+=1

proc part_one(): int =
    for l in lines:
        let instr = l.split(" ")[0]
        if instr == "noop":
            incCycle()
            continue
        
        let val = l.split(" ")[1].parseInt() 
        incCycle()
        register += val 
        incCycle()

    return sum(signals)

proc part_two() =
    cycle = 1
    register = 1
    for l in lines:
        let instr = l.split(" ")[0]
        if instr == "noop":
            drawCycle()
            continue

        let val = l.split(" ")[1].parseInt() 
        drawCycle()
        register += val 
        sprite = @[register-1, register, register+1]
        drawCycle()
        

echo "Part one: ", part_one()
echo "Part two: "
part_two()