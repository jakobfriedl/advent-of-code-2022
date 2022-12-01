import strutils, sequtils
import algorithm, math
import sugar

var file = "./test.txt"

var lines = readFile(file).splitLines()
