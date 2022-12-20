import std/[
    strutils, sequtils, strscans, 
    algorithm, math,
    sugar
]

const file = "./test.txt"
let lines = readFile(file).strip().splitLines()

const MINUTES = 24

proc part_one(): int =
    var 
        id: int
        oreRobotCost: int
        clayRobotCost: int
        obsidianRobotOreCost: int
        obisidianRobotClayCost: int
        geodeRobotOreCost: int
        geodeRobotObsidianCost: int
     
    for l in lines: 
        discard scanf(l, "Blueprint $i: Each ore robot costs $i ore. Each clay robot costs $i ore. Each obsidian robot costs $i ore and $i clay. Each geode robot costs $i ore and $i obsidian.", id, oreRobotCost, clayRobotCost, obsidianRobotOreCost, obisidianRobotClayCost, geodeRobotOreCost, geodeRobotObsidianCost)

        var 
            oreRobots = 1
            clayRobots = 0
            obsidianRobots = 0
            geodeRobots = 0

            ore = 0
            clay = 0
            obsidian = 0
            geodes = 0

            newRobot: string = ""

        for i in countup(1, MINUTES): 
            echo "====================="
            echo "Minute ", i
            # begin production of best possible robot
            if ore >= geodeRobotOreCost and obsidian >= geodeRobotObsidianCost:
                echo "Spending ", geodeRobotOreCost, " ore and ", geodeRobotObsidianCost, " obsidian to make a geode robot."
                echo "Ore: ", ore, " -> ", ore-geodeRobotOreCost
                echo "Obsidian: ", obsidian, " -> ", obsidian-geodeRobotObsidianCost

                ore -= geodeRobotOreCost
                obsidian -= geodeRobotObsidianCost
                newRobot = "geode"
            elif ore >= obsidianRobotOreCost and clay >= obisidianRobotClayCost: 
                echo "Spending ", obsidianRobotOreCost, " ore and ", obisidianRobotClayCost, " clay to make an obsidian robot."
                echo "Ore: ", ore, " -> ", ore-obsidianRobotOreCost
                echo "Clay: ", clay, " -> ", clay-obisidianRobotClayCost

                ore -= obsidianRobotOreCost
                clay -= obisidianRobotClayCost
                newRobot = "obsidian"
            elif ore >= oreRobotCost: 
                echo "Spending ", oreRobotCost, " ore to make an ore robot."
                echo "Ore: ", ore, " -> ", ore-oreRobotCost

                ore -= oreRobotCost
                newRobot = "ore"
            elif ore >= clayRobotCost: 
                echo "Spending ", clayRobotCost, " ore to make a clay robot."
                echo "Ore: ", ore, " -> ", ore-clayRobotCost

                ore -= clayRobotCost
                newRobot = "clay"

            # collect materials
            echo "Collecting ore: ", ore, " -> ", ore+oreRobots
            ore += oreRobots
            echo "Collecting clay: ", clay, " -> ", clay+clayRobots
            clay += clayRobots
            echo "Collecting obsidian: ", obsidian, " -> ", obsidian+obsidianRobots
            obsidian += obsidianRobots
            echo "Collecting geodes: ", geodes, " -> ", geodes+geodeRobots
            geodes += geodeRobots

            # increase count of newly produced robots
            case newRobot:
            of "ore": 
                oreRobots += 1
                echo "Produced Ore Robot. Currently: ", oreRobots
            of "clay":
                clayRobots += 1
                echo "Produced Clay Robot. Currently: ", clayRobots
            of "obsidian":
                obsidianRobots += 1
                echo "Produced Obsidian Robot. Currently: ", obsidianRobots
            of "geode":
                geodeRobots += 1
                echo "Produced Geode Robot. Currently: ", geodeRobots

            newRobot = ""

proc part_two(): int =
    discard

echo "Part one: ", part_one()
echo "Part two: ", part_two()