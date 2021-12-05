import Foundation

let url = Bundle.module.url(forResource: "day1", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n").compactMap { Int($0) }
print(zip(lines, lines[3...]).reduce(0, { $0 + ($1.0 < $1.1 ? 1 : 0) }))
