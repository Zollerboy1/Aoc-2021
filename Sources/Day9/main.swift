import Foundation

//Uncomment all commented lines except this one and you've got a nice animation of this algorithm working

let url = Bundle.module.url(forResource: "day9", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let matrix = lines.map { $0.map { Int(String($0))! } }

var basinMatrix = [[Int]](repeating: [Int](repeating: -2, count: matrix.first!.count), count: matrix.count)

var nextBasin = 0

//var firstTime = true
//let colorForHeight = [
//    1,
//    196,
//    160,
//    197,
//    125,
//    89,
//    53,
//    17,
//    18
//]

//func printMatrix() {
//    var string = ""
//
//    if firstTime {
//        firstTime = false
//    } else {
//        string += "\u{001B}[\(matrix.count)F"
//    }
//
//    for (i, row) in matrix.enumerated() {
//        for (j, height) in row.enumerated() {
//            switch basinMatrix[i][j] {
//            case -2: string += "\u{001B}[48;5;\(255 - ((9 - height) * 2))m\(height)"
//            case -1: string += "\u{001B}[48;5;4m9"
//            default: string += "\u{001B}[48;5;\(colorForHeight[height])m\(height)"
//            }
//        }
//
//        string += "\n"
//    }
//
//    print(string, terminator: "\u{001B}[0m")
//}

func visit(i: Int, j: Int) {
    if matrix[i][j] == 9 || basinMatrix[i][j] >= 0 {
        return
    }
    
    basinMatrix[i][j] = nextBasin
    
//    printMatrix()
    
    var checkIs = [-1, 1]
    var checkJs = [-1, 1]
    
    if i == 0 {
        checkIs.removeFirst()
    } else if i == matrix.count - 1 {
        checkIs.removeLast()
    }
    
    if j == 0 {
        checkJs.removeFirst()
    } else if j == matrix.first!.count - 1 {
        checkJs.removeLast()
    }
    
    for checkI in checkIs {
        visit(i: i + checkI, j: j)
    }
    
    for checkJ in checkJs {
        visit(i: i, j: j + checkJ)
    }
}

for (i, row) in matrix.enumerated() {
    for j in 0..<row.count {
        if matrix[i][j] == 9 {
            basinMatrix[i][j] = -1
//            printMatrix()
        } else if basinMatrix[i][j] >= 0 {
            continue
        }
        
        visit(i: i, j: j)
        nextBasin += 1
    }
}

//printMatrix()

var basinSizes = [Int](repeating: 0, count: nextBasin)
for row in basinMatrix {
    for basinNumber in row {
        if basinNumber != -1 {
            basinSizes[basinNumber] += 1
        }
    }
}

basinSizes.sort()

//print("")
print(basinSizes[nextBasin - 1] * basinSizes[nextBasin - 2] * basinSizes[nextBasin - 3])
