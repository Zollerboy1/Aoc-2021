import Foundation

enum Instruction {
    case x(Int)
    case y(Int)
}

let url = Bundle.module.url(forResource: "day13", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let parts = fileContents.components(separatedBy: "\n\n")

let startingDots = parts[0].split(separator: "\n").map { $0.split(separator: ",") }.map { (Int($0[0])!, Int($0[1])!) }

let instructions: [Instruction] = parts[1].split(separator: "\n").map { instructionLine in
    var instructionLine = instructionLine
    if instructionLine.starts(with: "fold along x=") {
        instructionLine.removeAll { !$0.isNumber }
        return Instruction.x(Int(instructionLine)!)
    } else {
        instructionLine.removeAll { !$0.isNumber }
        return Instruction.y(Int(instructionLine)!)
    }
}


var largestX = 0
var largestY = 0
for (x, y) in startingDots {
    largestX = max(largestX, x)
    largestY = max(largestY, y)
}

var dots = [[Bool]](repeating: [Bool](repeating: false, count: largestX + 1), count: largestY + 1)
for (x, y) in startingDots {
    dots[y][x] = true
}


for instruction in instructions {
    switch instruction {
    case let .x(x):
        let dotWidth = dots[0].count
        for i in 0..<dots.count {
            var row = dots[i]
            for j in ((x + 1)..<dotWidth).reversed() {
                let foldedJ = x * 2 - j
                
                let rowJ = row.remove(at: j)
                
                row[foldedJ] = row[foldedJ] || rowJ
            }
            
            row.remove(at: x)
            
            dots[i] = row
        }
       
    case let .y(y):
        for i in ((y + 1)..<dots.count).reversed() {
            let foldedI = y * 2 - i
            let row = dots.remove(at: i)
            
            for j in 0..<dots[foldedI].count {
                dots[foldedI][j] = dots[foldedI][j] || row[j]
            }
        }
        
        dots.remove(at: y)
    }
}

var dotCount = 0
for row in dots {
    for isDot in row {
        dotCount += isDot ? 1 : 0
    }
}

print(dots.count)
print(dots[0].count)

for row in dots {
    for isDot in row {
        print(isDot ? "#" : ".", terminator: "")
    }
    print("")
}

print(dotCount)
