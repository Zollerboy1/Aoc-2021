import Foundation

let url = Bundle.module.url(forResource: "day17", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

var firstLine = lines.first!

firstLine = firstLine.drop { !$0.isNumber && $0 != "-" }

let firstX = Int(firstLine.prefix { $0.isNumber || $0 == "-" })!
firstLine = firstLine.drop { $0.isNumber || $0 == "-" }

firstLine = firstLine.drop { !$0.isNumber && $0 != "-" }

let secondX = Int(firstLine.prefix { $0.isNumber || $0 == "-" })!
firstLine = firstLine.drop { $0.isNumber || $0 == "-" }

firstLine = firstLine.drop { !$0.isNumber && $0 != "-" }

let firstY = Int(firstLine.prefix { $0.isNumber || $0 == "-" })!
firstLine = firstLine.drop { $0.isNumber || $0 == "-" }

firstLine = firstLine.drop { !$0.isNumber && $0 != "-" }

let secondY = Int(firstLine.prefix { $0.isNumber || $0 == "-" })!


let targetXRange = firstX < secondX ? firstX...secondX : secondX...firstX
let targetYRange = firstY < secondY ? firstY...secondY : secondY...firstY



let startPosition = (0, 0)

var count = 0
for xVelocity in 0..<210 {
    for yVelocity in -108...300 {
        var velocity = (xVelocity, yVelocity)
        
        var currentPosition = startPosition
        for _ in 0..<350 {
            currentPosition = (currentPosition.0 + velocity.0, currentPosition.1 + velocity.1)
            
            if targetXRange.contains(currentPosition.0) && targetYRange.contains(currentPosition.1) {
                count += 1
                break
            }
            
            velocity = (velocity.0 > 0 ? velocity.0 - 1 : (velocity.0 < 0 ? velocity.0 + 1 : 0), velocity.1 - 1)
        }
    }
}

print(count)
