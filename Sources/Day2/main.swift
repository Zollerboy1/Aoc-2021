import Foundation

let url = Bundle.module.url(forResource: "day2", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)

var horizontal = 0
var depth = 0
var aim = 0

for line in fileContents.split(separator: "\n") {
    let split = line.split(separator: " ")
    
    let command = split[0]
    let number = Int(split[1])!
    
    switch command {
    case "forward":
        horizontal += number
        depth += aim * number
    case "up":
        aim -= number
    case "down":
        aim += number
    default:
        fatalError()
    }
}

print(horizontal * depth)
