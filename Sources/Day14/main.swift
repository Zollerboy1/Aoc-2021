import Foundation

let url = Bundle.module.url(forResource: "day14", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n").filter { !$0.isEmpty }


let template = lines.first!

let insertionRules: [String: (String, String)] = .init(uniqueKeysWithValues: lines.dropFirst().map { $0.components(separatedBy: " -> ") }.map { ($0[0], (String($0[0].first!) + $0[1], $0[1] + String($0[0].last!))) })


var polymer: [String: Int] = .init(zip(template.dropLast(), template.dropFirst()).map { (String($0.0) + String($0.1), 1) }, uniquingKeysWith: +)
for _ in 0..<40 {
    var nextPolymer = [String: Int]()
    for (pair, pairCount) in polymer {
        let newPairs = insertionRules[pair]!
        
        if nextPolymer[newPairs.0] != nil {
            nextPolymer[newPairs.0]! += pairCount
        } else {
            nextPolymer[newPairs.0] = pairCount
        }
        
        if nextPolymer[newPairs.1] != nil {
            nextPolymer[newPairs.1]! += pairCount
        } else {
            nextPolymer[newPairs.1] = pairCount
        }
    }
    
    polymer = nextPolymer
}

var elementCount = [Character: Int]()
elementCount[template.first!] = 1
for (pair, pairCount) in polymer {
    if elementCount[pair.last!] != nil {
        elementCount[pair.last!]! += pairCount
    } else {
        elementCount[pair.last!] = pairCount
    }
}

let mostCommonElementCount = elementCount.max(by: { $0.value < $1.value })!.value
let leastCommonElementCount = elementCount.min(by: { $0.value < $1.value })!.value

print(mostCommonElementCount - leastCommonElementCount)
