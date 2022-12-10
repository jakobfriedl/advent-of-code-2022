import strutils, sets


const file = "./input.txt"
let lines = readFile(file).splitLines()

func moveHead(head: var (int, int), d: string): (int, int) =
    case d:
    of "U": inc(head[1])
    of "R": inc(head[0])
    of "D": dec(head[1])
    of "L": dec(head[0])
    return head

proc moveTail(tail, head: (int, int)): bool =
    return abs(head[0] - tail[0]) > 1 or abs(head[1] - tail[1]) > 1

proc part_one(): int =
    var visisted: HashSet[(int, int)] = initHashSet[(int, int)]()
    var head = (0,0)
    var tail = (0,0)

    for l in lines: 
        let dir = l.split(" ")[0]
        case dir:
        of "U":
            for i in 1..l.split(" ")[1].parseInt():
                head = moveHead(head, dir)
                if moveTail(tail, head): 
                    tail = (head[0], head[1] - 1)
                visisted.incl(tail)
        of "R":
            for i in 1..l.split(" ")[1].parseInt():
                head = moveHead(head, dir)
                if moveTail(tail, head): 
                    tail = (head[0] - 1, head[1])
                visisted.incl(tail)
        of "D":
            for i in 1..l.split(" ")[1].parseInt():
                head = moveHead(head, dir)
                if moveTail(tail, head): 
                    tail = (head[0], head[1] + 1)
                visisted.incl(tail)
        of "L": 
            for i in 1..l.split(" ")[1].parseInt():
                head = moveHead(head, dir)
                if moveTail(tail, head): 
                    tail = (head[0] + 1, head[1])
                visisted.incl(tail)
    
    result = visisted.len

proc part_two(): int =
    var visisted: HashSet[(int, int)] = initHashSet[(int, int)]()
    var rope: array[10, (int, int)] = [(0,0), (0,0), (0,0), (0,0), (0,0), (0,0), (0,0), (0,0), (0,0), (0,0)]
    
    for l in lines: 
        let dir = l.split(" ")[0]
        case dir:
        of "U":
            for i in 1..l.split(" ")[1].parseInt():
                rope[0] = moveHead(rope[0], dir)
                
                for j in 1..rope.high:
                    if moveTail(rope[j], rope[j - 1]): 
                        rope[j][0] += cmp(rope[j-1][0], rope[j][0])
                        rope[j][1] += cmp(rope[j-1][1], rope[j][1])

                visisted.incl(rope[^1])
        of "R":
            for i in 1..l.split(" ")[1].parseInt():
                rope[0] = moveHead(rope[0], dir)

                for j in 1..rope.high:
                    if moveTail(rope[j], rope[j - 1]): 
                        rope[j][0] += cmp(rope[j-1][0], rope[j][0])
                        rope[j][1] += cmp(rope[j-1][1], rope[j][1])

                visisted.incl(rope[^1])
        of "D":
            for i in 1..l.split(" ")[1].parseInt():
                rope[0] = moveHead(rope[0], dir)

                for j in 1..rope.high:
                    if moveTail(rope[j], rope[j - 1]): 
                        rope[j][0] += cmp(rope[j-1][0], rope[j][0])
                        rope[j][1] += cmp(rope[j-1][1], rope[j][1])

                visisted.incl(rope[^1])
        of "L": 
            for i in 1..l.split(" ")[1].parseInt():
                rope[0] = moveHead(rope[0], dir)

                for j in 1..rope.high:
                    if moveTail(rope[j], rope[j - 1]): 
                        rope[j][0] += cmp(rope[j-1][0], rope[j][0])
                        rope[j][1] += cmp(rope[j-1][1], rope[j][1])
                
                visisted.incl(rope[^1])
    
    result = visisted.len

echo "Part one: ", part_one()
echo "Part two: ", part_two()