import Foundation

struct Point {
    let x, y: Int
}

let url = Bundle.module.url(forResource: "day5", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")


let regex = try! NSRegularExpression(pattern: "^(\\d+),(\\d+) -> (\\d+),(\\d+)$", options: [])

let lineEndPoints: [(Point, Point)] = lines.map {
    let match = regex.firstMatch(in: String($0), options: [], range: NSRange(location: 0, length: $0.utf16.count))!
    let first = Range(match.range(at: 1), in: $0)!
    let second = Range(match.range(at: 2), in: $0)!
    let third = Range(match.range(at: 3), in: $0)!
    let fourth = Range(match.range(at: 4), in: $0)!
    
    return (Point(x: Int($0[first])!, y: Int($0[second])!), Point(x: Int($0[third])!, y: Int($0[fourth])!))
}

let m = lineEndPoints.reduce(0) { max($0, max($1.0.y, $1.1.y)) } + 1
let n = lineEndPoints.reduce(0) { max($0, max($1.0.x, $1.1.x)) } + 1

var grid = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)

for endPoints in lineEndPoints {
    if endPoints.0.x == endPoints.1.x {
        if endPoints.0.y < endPoints.1.y {
            for y in endPoints.0.y...endPoints.1.y {
                grid[y][endPoints.0.x] += 1
            }
        } else {
            for y in endPoints.1.y...endPoints.0.y {
                grid[y][endPoints.0.x] += 1
            }
        }
    } else if endPoints.0.y == endPoints.1.y {
        if endPoints.0.x < endPoints.1.x {
            for x in endPoints.0.x...endPoints.1.x {
                grid[endPoints.0.y][x] += 1
            }
        } else {
            for x in endPoints.1.x...endPoints.0.x {
                grid[endPoints.0.y][x] += 1
            }
        }
    } else if endPoints.0.x < endPoints.1.x {
        if endPoints.0.y < endPoints.1.y {
            for (x, y) in zip(endPoints.0.x...endPoints.1.x, endPoints.0.y...endPoints.1.y) {
                grid[y][x] += 1
            }
        } else {
            for (x, y) in zip(endPoints.0.x...endPoints.1.x, (endPoints.1.y...endPoints.0.y).reversed()) {
                grid[y][x] += 1
            }
        }
    } else {
        if endPoints.0.y < endPoints.1.y {
            for (x, y) in zip((endPoints.1.x...endPoints.0.x).reversed(), endPoints.0.y...endPoints.1.y) {
                grid[y][x] += 1
            }
        } else {
            for (x, y) in zip((endPoints.1.x...endPoints.0.x).reversed(), (endPoints.1.y...endPoints.0.y).reversed()) {
                grid[y][x] += 1
            }
        }
    }
}

var count = 0

for i in 0..<m {
    for j in 0..<n {
        if grid[i][j] >= 2 {
            count += 1
        }
    }
}

print(count)
