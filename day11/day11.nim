import std/[strutils, sequtils, math, algorithm]

const file = "./input.txt"
let lines = readFile(file).strip().split("\n\n")

type 
    Monkey = object
        items: seq[int]
        operation: string
        testDivision: int
        ifTrue: int
        ifFalse: int 
        inspected: int

func calculateWorryLevel(operation: string, divisor: int, modulo: int): int = 
    let num1 = operation.split(" ")[0].parseInt()
    let op = operation.split(" ")[1]
    let num2 = operation.split(" ")[2].parseInt()

    case op
    of "+": result = num1 + num2
    of "*": result = num1 * num2 mod modulo

    result = floor(result.float / divisor.float).int

proc parseInputs(): seq[Monkey] = 
    for i, m in lines: 
        var ape = Monkey()
        for l in m.splitLines().mapIt(it.replace("  ", "")):
            if l.startsWith("Starting items:"):
                ape.items = l.replace("Starting items: ", "").split(", ").map(parseInt)
            if l.startsWith("Operation:"):
                ape.operation = l.replace("Operation: new = ", "")
            if l.startsWith("Test:"):
                ape.testDivision = parseInt(l.replace("Test: divisible by ", ""))
            if l.startsWith("If true:"): 
                ape.ifTrue = parseInt(l.replace("If true: throw to monkey ", ""))
            if l.startsWith("If false:"):
                ape.ifFalse = parseInt(l.replace("If false: throw to monkey ", ""))
        result.add(ape)

proc solve(rounds: int, divide: int): int = 
    var 
        monkeys = parseInputs()
        monkeyBusiness: seq[int]

    let largestCommonMultiple = lcm(monkeys.mapIt(it.testDivision))

    for i in 1..rounds:
        for num, m in monkeys: 
            for index, item in m.items: 
                let worryLevel = calculateWorryLevel(m.operation.replace("old", $item), divide, largestCommonMultiple)
                monkeys[num].inspected += 1
                if worryLevel mod m.testDivision == 0: 
                    monkeys[m.ifTrue].items.add(worryLevel)
                else:
                    monkeys[m.ifFalse].items.add(worryLevel)
            
            if m.items.len > 0: 
                monkeys[num].items.delete(0..<monkeys[num].items.len)

    for m in monkeys:
        monkeyBusiness.add(m.inspected)
    monkeyBusiness.sort

    result = monkeyBusiness[^1]*monkeyBusiness[^2]

echo "Part one: ", solve(20, 3)
echo "Part two: ", solve(10000, 1)