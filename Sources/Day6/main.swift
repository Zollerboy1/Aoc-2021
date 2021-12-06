import Foundation

let url = Bundle.module.url(forResource: "day6", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let initialAges = lines.first!.split(separator: ",").compactMap { Int($0) }


var ageCounts = initialAges.reduce(into: [Int](repeating: 0, count: 9)) { $0[$1] += 1 }
for _ in 0..<256 {
    var newAgeCounts = [Int](repeating: 0, count: 9)
    
    for (i, ageCount) in ageCounts.enumerated() {
        if i == 0 {
            newAgeCounts[8] += ageCount
            newAgeCounts[6] += ageCount
        } else {
            newAgeCounts[i - 1] += ageCount
        }
    }
    
    ageCounts = newAgeCounts
    
    
}

print(ageCounts.reduce(0) { $0 + $1 })
