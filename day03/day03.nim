import strutils, sequtils
import sugar

var 
    file = "./input.txt"
    lines = readFile(file).splitLines()

const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func group(lines: seq[string]): seq[seq[string]] =
    var counter = 0
    var temp : seq[string]
    for l in lines:
        temp.add(l)
        counter += 1
        if counter mod 3 == 0:
            result.add(temp)
            temp = @[]

proc part_one(): int = 
    for l in lines: 
        let first = l.substr(0, int(l.len/2)-1).toSeq()
        let second = l.substr(int(l.len/2), l.len-1).toSeq()

        let duplicate = first.filter(x => second.contains(x))[0]    
        result += chars.find(duplicate) + 1

proc part_two(): int = 
    var groups = lines.group()
    for g in groups:
        let 
            first = g[0].toSeq()
            second = g[1].toSeq()
            third = g[2].toSeq()

        let duplicate = first.filter(x => second.contains(x) and third.contains(x))[0]
        result += chars.find(duplicate) + 1
    
echo "Part one: ", part_one()
echo "Part two: ", part_two()