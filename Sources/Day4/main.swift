import Foundation

struct Board {
    let lines: [[Int]]
    var marked: [[Bool]]
    
    func hasBingo() -> Bool {
        for line in marked {
            if !line.contains(false) {
                return true
            }
        }
        
        for i in 0..<5 {
            var wasFalse = false
            for line in marked {
                if line[i] == false {
                    wasFalse = true
                    break
                }
            }
            
            if !wasFalse {
                return true
            }
        }
        
        return false
    }
}

let url = Bundle.module.url(forResource: "day4", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)

var lines = fileContents.split(separator: "\n")

let firstLine = lines.removeFirst()

let order = firstLine.split(separator: ",").compactMap { Int($0) }


var boards = [Board]()
for i in stride(from: lines.startIndex, to: lines.endIndex, by: 5) {
    boards.append(Board(lines: lines[i..<(i + 5)].map({ $0.split(separator: " ").compactMap { Int($0) } }), marked: [[Bool]](repeating: [Bool](repeating: false, count: 5), count: 5)))
}


outer: for number in order {
    var boardsToRemove = [Int]()
    for (boardIndex, board) in boards.enumerated() {
        for (i, line) in board.lines.enumerated() {
            for (j, field) in line.enumerated() {
                if number == field {
                    boards[boardIndex].marked[i][j] = true
                }
            }
        }
        
        if boards[boardIndex].hasBingo() {
            if boards.count > 1 {
                boardsToRemove.append(boardIndex)
            } else {
                var sum = 0
                
                for (i, line) in boards[boardIndex].marked.enumerated() {
                    for (j, field) in line.enumerated() {
                        if !field {
                            sum += board.lines[i][j]
                        }
                    }
                }
                
                print(sum * number)
                
                break outer
            }
        }
    }
    
    for boardToRemove in boardsToRemove.sorted(by: >) {
        boards.remove(at: boardToRemove)
    }
}
