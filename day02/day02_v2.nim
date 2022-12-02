import strutils, sequtils

var file = "./input.txt"

var lines = readFile(file).splitLines().mapIt(it.split(' '))
const abc: string = "ABC"
const xyc: string = "XYZ" 

#[
    A|X -beats-> C|Z -beats-> B|Y
    B|Y -beats-> A|X -beats-> C|Z
    C|Z -beats-> B|Y -beats-> A|X
]#

func get_outcome(opponent: int, elf: int): int = 
    if opponent == elf: return 3 # Draw
    if (opponent + 1) mod 3 == elf mod 3: return 6 # Elf wins against opponent
    return 0 # Elf looses against opponent

func get_elf(outcome: int, opponent: int): int = 
    if outcome == 6: # Elf needs to win
        return (opponent mod 3) + 1
    if outcome == 0: # Elf needs to lose
        let elf = (opponent - 1) mod 3
        if elf == 0: return 3
        return elf
    return opponent # Draw

proc part_one(): int = 
    var points: int = 0
    for l in lines:
        let opponent = abc.find(l[0]) + 1
        let elf = xyc.find(l[1]) + 1

        points += elf + get_outcome(opponent, elf)
    return points

proc part_two() : int = 
    var points: int = 0
    for l in lines:
        let opponent = abc.find(l[0]) + 1
        let outcome = xyc.find(l[1]) * 3 # X: 0*3=0, Y=1*3=3, Z=2*3=6
        
        points += get_elf(outcome, opponent) + outcome
    return points

echo "Part one: ", part_one()
echo "Part two: ", part_two()