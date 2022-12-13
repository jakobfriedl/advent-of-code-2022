import std/[strutils, sequtils, algorithm]

type 
    Comparision = enum
        LESS_THAN,
        GREATER_THAN,
        EQUAL
    PacketType = enum 
        INTEGER,
        LIST
    Packet = object
        case packetType:PacketType
        of INTEGER: intVal: int
        of LIST: listVal: seq[Packet]

const file = "./input.txt"
let lines = readFile(file).strip().split("\n\n")    
let lines_part_two = readFile(file).strip().splitLines().filterIt(it.len > 0) & @["[[2]]", "[[6]]"]

proc parseInput(packet: string, offset: int): (Packet, int) = 
    var i = offset
    var lastNum = ""
    var packets: seq[Packet] = @[]

    while i < packet.len:
        inc i
        if packet[i] == '[':
            let (inner, offset2) = parseInput(packet, i)
            i = offset2
            packets.add(inner)
        elif packet[i] == ']':
            break
        elif packet[i] == ',':
            if lastNum.len > 0:
                packets.add(Packet(packetType: INTEGER, intVal: lastNum.parseInt()))
                lastNum = ""
        else:
            lastNum &= packet[i]
    
    if lastNum.len > 0:
        packets.add(Packet(packetType: INTEGER, intVal: lastNum.parseInt()))

    return (Packet(packetType: LIST, listVal: packets), i)

proc compare(packet1, packet2: Packet): Comparision = 
    if packet1.packetType == INTEGER and packet2.packetType == INTEGER:
        if packet1.intVal < packet2.intVal: return LESS_THAN
        if packet1.intVal > packet2.intVal: return GREATER_THAN
        return EQUAL
    
    if packet1.packetType == LIST and packet2.packetType == LIST:
        for i in 0..<max(packet1.listVal.len, packet2.listVal.len):
            if i >= packet1.listVal.len:
                return LESS_THAN
            if i >= packet2.listVal.len:
                return GREATER_THAN

            let res = compare(packet1.listVal[i], packet2.listVal[i])
            if res != EQUAL:
                return res
        return EQUAL

    if packet1.packetType == INTEGER and packet2.packetType == LIST:
        return compare(Packet(packetType: LIST, listVal: @[packet1]), packet2)

    if packet1.packetType == LIST and packet2.packetType == INTEGER:
        return compare(packet1, Packet(packetType: LIST, listVal: @[packet2]))

proc compareLines(line1, line2: string): int = 
    let packet1 = parseInput(line1, 0)[0]
    let packet2 = parseInput(line2, 0)[0]
    case compare(packet1, packet2)
    of LESS_THAN: return -1
    of GREATER_THAN: return 1
    of EQUAL: return 0

proc part_one(): int = 
    for index, group in lines: 
        if compareLines(group.splitLines()[0], group.splitLines()[1]) <= 0:
            result += (index+1)

proc part_two(): int =
    let sorted = lines_part_two.sorted(compareLines)
    result = (sorted.find("[[2]]") + 1) * (sorted.find("[[6]]") + 1)

echo "Part one: ", part_one()
echo "Part two: ", part_two()