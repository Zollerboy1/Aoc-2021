import Foundation

let url = Bundle.module.url(forResource: "day7", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let crabs = lines.first!.split(separator: ",").compactMap { Int($0) }


let sum = crabs.reduce(0) { $0 + $1 }

let mean = sum / crabs.count

var fuelCost = 0
for crab in crabs {
    for j in 0..<Int((crab - mean).magnitude) {
        fuelCost += j + 1
    }
}

var meanFuelCost = fuelCost


fuelCost = 0
for crab in crabs {
    for j in 0..<Int((crab - (mean - 1)).magnitude) {
        fuelCost += j + 1
    }
}

var lowerFuelCost = fuelCost


fuelCost = 0
for crab in crabs {
    for j in 0..<Int((crab - (mean + 1)).magnitude) {
        fuelCost += j + 1
    }
}

var higherFuelCost = fuelCost

var lastFuelCost: Int
if (lowerFuelCost < meanFuelCost) {
    var i = mean - 1
    
    lastFuelCost = meanFuelCost
    var currentFuelCost = lowerFuelCost
    
    while currentFuelCost < lastFuelCost {
        var fuelCost = 0
        for crab in crabs {
            for j in 0..<Int((crab - i).magnitude) {
                fuelCost += j + 1
            }
        }
        
        lastFuelCost = currentFuelCost
        currentFuelCost = fuelCost
        i -= 1
    }
} else {
    var i = mean + 1
    
    lastFuelCost = meanFuelCost
    var currentFuelCost = higherFuelCost
    
    while currentFuelCost < lastFuelCost {
        var fuelCost = 0
        for crab in crabs {
            for j in 0..<Int((crab - i).magnitude) {
                fuelCost += j + 1
            }
        }
        
        lastFuelCost = currentFuelCost
        currentFuelCost = fuelCost
        i += 1
    }
}

print(lastFuelCost)
