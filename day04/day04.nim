import strutils, sequtils

const file = "./input.txt"
let lines = readFile(file).splitLines()

proc part_one(): int = 
    for l in lines:
        let tasks = l.split(",")
        let elf1: seq[int] = tasks[0].split("-").map(parseInt)
        let elf2: seq[int] = tasks[1].split("-").map(parseInt)

        if elf1[0] >= elf2[0] and elf1[1] <= elf2[1] or elf2[0] >= elf1[0] and elf2[1] <= elf1[1]: result += 1

proc part_two(): int =
    for l in lines:
        let tasks = l.split(",")
        let elf1: seq[int] = tasks[0].split("-").map(parseInt)
        let elf2: seq[int] = tasks[1].split("-").map(parseInt)

        for i in elf1[0]..elf1[1]:
            if i in elf2[0]..elf2[1]: 
                result += 1
                break

echo "Part one: ", part_one()
echo "Part two: ", part_two()