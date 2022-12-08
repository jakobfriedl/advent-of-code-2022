import std/[strutils, sequtils, tables]

const file = "./input.txt"
let commands = readFile(file).split("$ ")[1..^1]

var dirs: CountTable[string] = initCountTable[string]()
var pwd: string = ""

for c in commands: 
    for l in c.splitLines.filterIt(it.len > 0): 
        if l.startsWith("ls") or l.startsWith("dir"): continue
        let args = l.split(" ")
        if args[0] == "cd": 
            if args[1] != "..":
                if pwd == "": pwd = args[1]
                else: pwd &= "-" & args[1]
            else: 
                pwd = pwd.rsplit("-", 1)[0]
        else:
            let size = args[0].parseInt() 
            var tmp = pwd
            while tmp != "/":
                dirs.inc(tmp, size)
                tmp = tmp.rsplit("-", 1)[0]
            dirs.inc("/", size)

proc part_one(): int = 
    for key, val in dirs.mpairs: 
        if val <= 100000:
            result += val

proc part_two(): int =
    const totalSpace = 70000000
    const neededSpace = 30000000
    let unusedSpace = totalSpace - dirs["/"]
    
    while result == 0:
        let smallest = dirs.smallest
        if smallest.val + unusedSpace < neededSpace:
            dirs.del(smallest.key)
        else: 
            result = smallest.val
            
echo "Part one: ", part_one()
echo "Part two: ", part_two()