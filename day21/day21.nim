import std/[strutils, tables, math]

type
    Equation = ref object
        value1: int
        value2: int
        result: int

const file = "./test.txt"
let lines = readFile(file).strip().splitLines()

var
    monkeys: Table[string, string]

for l in lines: 
    monkeys[l.split(": ")[0]] = l.split(": ")[1]

proc getValue(key: string): int =
    let val = monkeys[key]
    try:
        # value is a number
        return val.parseInt
    except ValueError:
        # value is an expression
        let ape1 = val.split(" ")[0]        
        let op = val.split(" ")[1]        
        let ape2 = val.split(" ")[2]        

        case op:
        of "+":
            return getValue(ape1) + getValue(ape2)
        of "-":
            return getValue(ape1) - getValue(ape2)
        of "*":
            return getValue(ape1) * getValue(ape2)
        of "/":
            return (getValue(ape1) / getValue(ape2)).floor.int

proc findValue(key: string, humn: int): Equation =
    if key == "humn": return Equation(result: humn)
    let val = monkeys[key]
    
    try:
        # value is a number
        return Equation(result: val.parseInt)
    except ValueError:
        # value is an expression
        let ape1 = val.split(" ")[0]        
        let op = val.split(" ")[1]        
        let ape2 = val.split(" ")[2]        

        if key == "root":
            let val1 = findValue(ape1, humn).result
            let val2 = findValue(ape2, humn).result
            return Equation(value1: val1, value2: val2, result: getValue(key))

        case op:
        of "+":
            return Equation(result: findValue(ape1, humn).result + findValue(ape2, humn).result)
        of "-":
            return Equation(result: findValue(ape1, humn).result - findValue(ape2, humn).result)
        of "*":
            return Equation(result: findValue(ape1, humn).result * findValue(ape2, humn).result)
        of "/":
            return Equation(result: (findValue(ape1, humn).result / findValue(ape2, humn).result).floor.int)

proc part_one(): int = 
    result = getValue("root")

proc part_two(): int =
    for i in 0..1000:
        let equation = findValue("root", i)
        if equation.value1 == equation.value2:
            result = i
            break
    
    # var lo: int = 0
    # var hi: int = 1e20.int
    # var mid: int = 1e10.int

    # while true:
    #     let equation = findValue("root", mid)

    #     echo mid, "=> ", equation.value1, " ", equation.value2
    #     echo "Lo-Hi: ", lo, " - ", hi
    #     if equation.value1 == equation.value2:
    #         break

    #     if (equation.value1 - equation.value2) > 0:
    #         hi = mid
    #     else:
    #         lo = mid

    #     mid = floorDiv((lo + hi), 2)

    # result = mid


echo "Part one: ", part_one()
echo "Part two: ", part_two()