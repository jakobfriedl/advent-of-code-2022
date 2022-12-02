import strutils, sequtils
import algorithm, math
import sugar
import tables

const values = {
    "A": 1,
    "B": 2,
    "C": 3,
    "X": 1,
    "Y": 2,
    "Z": 3,
}.toTable()

const win = {
    "Z": "B",
    "Y": "A",
    "X": "C"
}.toTable()

const win_reverse = {
    "B": "Z",
    "A": "Y",
    "C": "X"
}.toTable()

const draw = {
    "Z": "C",
    "Y": "B",
    "X": "A"
}.toTable()

const lose_reverse = {
    "C": "Y",
    "B": "X",
    "A": "Z"
}.toTable()

var file = "./input.txt"

var lines = readFile(file).splitLines().mapIt(it.split(' '))

var points_one : int = 0
for l in lines: 
    if win.getOrDefault(l[1]) == l[0]:
        points_one+=6
    elif draw.getOrDefault(l[1]) == l[0]:
        points_one+=3
    else: 
        points_one+=0

    if l[1] == "X":
        points_one+=1
    if l[1] == "Y":
        points_one+=2
    if l[1] == "Z":
        points_one+=3

var points_two : int = 0
for l in lines:
    case l[1]
    of "X":
        points_two+=0 + values[lose_reverse.getOrDefault(l[0])]
    of "Y":
        points_two+=3 + values[l[0]]
    of "Z": 
        points_two+=6 + values[win_reverse.getOrDefault(l[0])]


echo "Part one: ", points_one
echo "Part two: ", points_two