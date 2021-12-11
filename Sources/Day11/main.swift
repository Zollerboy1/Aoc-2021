import Foundation

let url = Bundle.module.url(forResource: "day11", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

var octopusMatrix = lines.map { $0.map { Int(String($0))! } }

var simulationRound = 0
simulationLoop: while true {
    simulationRound += 1
    
    for (i, row) in octopusMatrix.enumerated() {
        for j in 0..<row.count {
            if simulationRound <= 3 {
                print(octopusMatrix[i][j], terminator: "")
            }
        }
        if simulationRound <= 3 {
            print("")
        }
    }
    if simulationRound <= 3 {
        print("")
    }
    
    var alreadyFlashedMatrix = octopusMatrix.map { $0.map { _ in false } }
    
    for (i, row) in octopusMatrix.enumerated() {
        for j in 0..<row.count {
            octopusMatrix[i][j] += 1
            
            if octopusMatrix[i][j] > 9 {
                alreadyFlashedMatrix[i][j] = true
                var increaseIs = [-1, 0, 1]
                var increaseJs = [-1, 0, 1]
                
                if i == 0 {
                    increaseIs.removeFirst()
                } else if i == octopusMatrix.count - 1 {
                    increaseIs.removeLast()
                }
                
                if j == 0 {
                    increaseJs.removeFirst()
                } else if j == row.count - 1 {
                    increaseJs.removeLast()
                }
                
                for increaseI in increaseIs {
                    for increaseJ in increaseJs {
                        if !(increaseI == 0 && increaseJ == 0) {
                            octopusMatrix[i + increaseI][j + increaseJ] += 1
                        }
                    }
                }
            }
        }
    }
    
    for _ in 0..<100 {
        for (i, row) in octopusMatrix.enumerated() {
            for j in 0..<row.count {
                if !alreadyFlashedMatrix[i][j] && octopusMatrix[i][j] > 9 {
                    alreadyFlashedMatrix[i][j] = true
                    var increaseIs = [-1, 0, 1]
                    var increaseJs = [-1, 0, 1]
                    
                    if i == 0 {
                        increaseIs.removeFirst()
                    } else if i == octopusMatrix.count - 1 {
                        increaseIs.removeLast()
                    }
                    
                    if j == 0 {
                        increaseJs.removeFirst()
                    } else if j == row.count - 1 {
                        increaseJs.removeLast()
                    }
                    
                    for increaseI in increaseIs {
                        for increaseJ in increaseJs {
                            if !(increaseI == 0 && increaseJ == 0) {
                                octopusMatrix[i + increaseI][j + increaseJ] += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    for (i, row) in octopusMatrix.enumerated() {
        for j in 0..<row.count {
            if octopusMatrix[i][j] > 9 {
                octopusMatrix[i][j] = 0
            }
        }
    }
    
    for row in alreadyFlashedMatrix {
        for flashed in row {
            if !flashed {
                continue simulationLoop
            }
        }
    }
    
    print(simulationRound)
    break
}
