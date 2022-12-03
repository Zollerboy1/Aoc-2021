import Foundation

enum GridLocation: Character {
    case east = ">"
    case south = "v"
    case empty = "."
}

let url = Bundle.module.url(forResource: "day25", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")


var grid = lines.map { $0.map { GridLocation(rawValue: $0)! } }


var step = 0
while true {
    step += 1
    
    var moved = false
    
    var newGrid = [[GridLocation]](repeating: [GridLocation](repeating: .empty, count: grid[0].count), count: grid.count)
    
    for (i, row) in grid.enumerated() {
        for (j, location) in row.enumerated() {
            if location == .east {
                if j == grid[0].count - 1 {
                    if grid[i][0] == .empty {
                        newGrid[i][0] = .east
                        moved = true
                    } else {
                        newGrid[i][j] = .east
                    }
                } else {
                    if grid[i][j + 1] == .empty {
                        newGrid[i][j + 1] = .east
                        moved = true
                    } else {
                        newGrid[i][j] = .east
                    }
                }
            }
        }
    }
    
    for (i, row) in grid.enumerated() {
        for (j, location) in row.enumerated() {
            if location == .south {
                if i == grid.count - 1 {
                    if newGrid[0][j] == .empty && grid[0][j] != .south {
                        newGrid[0][j] = .south
                        moved = true
                    } else {
                        newGrid[i][j] = .south
                    }
                } else {
                    if newGrid[i + 1][j] == .empty && grid[i + 1][j] != .south {
                        newGrid[i + 1][j] = .south
                        moved = true
                    } else {
                        newGrid[i][j] = .south
                    }
                }
            }
        }
    }
    
    if !moved {
        break
    } else {
        grid = newGrid
    }
}

print(step)
