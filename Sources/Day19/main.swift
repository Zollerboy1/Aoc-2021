import Foundation

struct Point: Equatable, Hashable {
    let x, y, z: Int
    
    init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }
    
    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    func distanceSquared(to other: Point) -> Int {
        ((other.x - x) * (other.x - x)) + ((other.y - y) * (other.y - y)) + ((other.z - z) * (other.z - z))
    }
    
    func manhattanDistance(to other: Point) -> Int {
        Int((other.x - x).magnitude) + Int((other.y - y).magnitude) + Int((other.z - z).magnitude)
    }
}

struct Scanner {
    let index: Int
    let position: Point
    let absoluteBeaconPoints: [Point]
    let distances: [Int]
}

let url = Bundle.module.url(forResource: "day19", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let allScannerLines = lines.split { $0.starts(with: "--- scanner ") }

let allScannerPoints: [[Point]] = allScannerLines.map { (scannerLines: ArraySlice<Substring>) -> [Point] in
    scannerLines.filter({ !$0.isEmpty }).map({ $0.split(separator: ",") }).map { Point(x: Int($0[0])!, y: Int($0[1])!, z: Int($0[2])!) }
}


var scanner0Distances = [Int]()
for point in allScannerPoints[0] {
    for otherPoint in allScannerPoints[0] {
        scanner0Distances.append(point.distanceSquared(to: otherPoint))
    }
}
let scanner0 = Scanner(index: 0, position: .init(), absoluteBeaconPoints: allScannerPoints[0], distances: scanner0Distances)


var scanners = [scanner0]
var stillToDo = Array(1..<allScannerPoints.count)

outerLoop: while !stillToDo.isEmpty {
    let i = stillToDo.removeFirst()
    
    let scannerPoints = allScannerPoints[i]
    
    var scannerDistances = [Int]()
    for point in scannerPoints {
        for otherPoint in scannerPoints {
            scannerDistances.append(point.distanceSquared(to: otherPoint))
        }
    }
    
    for otherScanner in scanners {
        var pointDistances = [Int: (Int, [Int])]()
        for pointIndex in 0..<scannerPoints.count {
            var index: Int?
            for distance in scannerDistances[(pointIndex * scannerPoints.count + pointIndex + 1)..<((pointIndex + 1) * scannerPoints.count)] {
                if otherScanner.distances.contains(distance) {
                    index = otherScanner.distances.firstIndex(of: distance)! / otherScanner.absoluteBeaconPoints.count
                    break
                }
            }
            
            if let index = index {
                pointDistances[pointIndex] = (index, scannerDistances[(pointIndex * scannerPoints.count + pointIndex + 1)..<((pointIndex + 1) * scannerPoints.count)].filter { distance in
                    return otherScanner.distances[(index * otherScanner.absoluteBeaconPoints.count)..<((index + 1) * otherScanner.absoluteBeaconPoints.count)].contains(distance)
                })
            }
        }
        
        if pointDistances.count >= 11 {
            let pointDistancesSorted = pointDistances.sorted { $0.value.1.count > $1.value.1.count }
            
            let otherScannerPoint1 = otherScanner.absoluteBeaconPoints[pointDistancesSorted[0].value.0]
            let otherScannerPoint2 = otherScanner.absoluteBeaconPoints[pointDistancesSorted[1].value.0]
            
            let otherXDifference = otherScannerPoint2.x - otherScannerPoint1.x
            let otherYDifference = otherScannerPoint2.y - otherScannerPoint1.y
            let otherZDifference = otherScannerPoint2.z - otherScannerPoint1.z

            let point1 = scannerPoints[pointDistancesSorted[0].key]
            let point2 = scannerPoints[pointDistancesSorted[1].key]
            
            let xDifference = point2.x - point1.x
            let yDifference = point2.y - point1.y
            let zDifference = point2.z - point1.z
            
            
            let xMultipliers, yMultipliers, zMultipliers: (x: Int, y: Int, z: Int)
            if xDifference == otherXDifference && yDifference == otherYDifference && zDifference == otherZDifference {
                xMultipliers = (1, 0, 0)
                yMultipliers = (0, 1, 0)
                zMultipliers = (0, 0, 1)
            } else if xDifference == otherXDifference && yDifference == -otherYDifference && zDifference == -otherZDifference {
                xMultipliers = (1, 0, 0)
                yMultipliers = (0, -1, 0)
                zMultipliers = (0, 0, -1)
            } else if xDifference == otherXDifference && zDifference == otherYDifference && yDifference == -otherZDifference {
                xMultipliers = (1, 0, 0)
                yMultipliers = (0, 0, 1)
                zMultipliers = (0, -1, 0)
            } else if xDifference == otherXDifference && zDifference == -otherYDifference && yDifference == otherZDifference {
                xMultipliers = (1, 0, 0)
                yMultipliers = (0, 0, -1)
                zMultipliers = (0, 1, 0)
            } else if xDifference == -otherXDifference && yDifference == otherYDifference && zDifference == -otherZDifference {
                xMultipliers = (-1, 0, 0)
                yMultipliers = (0, 1, 0)
                zMultipliers = (0, 0, -1)
            } else if xDifference == -otherXDifference && yDifference == -otherYDifference && zDifference == otherZDifference {
                xMultipliers = (-1, 0, 0)
                yMultipliers = (0, -1, 0)
                zMultipliers = (0, 0, 1)
            } else if xDifference == -otherXDifference && zDifference == otherYDifference && yDifference == otherZDifference {
                xMultipliers = (-1, 0, 0)
                yMultipliers = (0, 0, 1)
                zMultipliers = (0, 1, 0)
            } else if xDifference == -otherXDifference && zDifference == -otherYDifference && yDifference == -otherZDifference {
                xMultipliers = (-1, 0, 0)
                yMultipliers = (0, 0, -1)
                zMultipliers = (0, -1, 0)
            } else if yDifference == otherXDifference && xDifference == otherYDifference && zDifference == -otherZDifference {
                xMultipliers = (0, 1, 0)
                yMultipliers = (1, 0, 0)
                zMultipliers = (0, 0, -1)
            } else if yDifference == otherXDifference && xDifference == -otherYDifference && zDifference == otherZDifference {
                xMultipliers = (0, 1, 0)
                yMultipliers = (-1, 0, 0)
                zMultipliers = (0, 0, 1)
            } else if yDifference == otherXDifference && zDifference == otherYDifference && xDifference == otherZDifference {
                xMultipliers = (0, 1, 0)
                yMultipliers = (0, 0, 1)
                zMultipliers = (1, 0, 0)
            } else if yDifference == otherXDifference && zDifference == -otherYDifference && xDifference == -otherZDifference {
                xMultipliers = (0, 1, 0)
                yMultipliers = (0, 0, -1)
                zMultipliers = (-1, 0, 0)
            } else if yDifference == -otherXDifference && xDifference == otherYDifference && zDifference == otherZDifference {
                xMultipliers = (0, -1, 0)
                yMultipliers = (1, 0, 0)
                zMultipliers = (0, 0, 1)
            } else if yDifference == -otherXDifference && xDifference == -otherYDifference && zDifference == -otherZDifference {
                xMultipliers = (0, -1, 0)
                yMultipliers = (-1, 0, 0)
                zMultipliers = (0, 0, -1)
            } else if yDifference == -otherXDifference && zDifference == otherYDifference && xDifference == -otherZDifference {
                xMultipliers = (0, -1, 0)
                yMultipliers = (0, 0, 1)
                zMultipliers = (-1, 0, 0)
            } else if yDifference == -otherXDifference && zDifference == -otherYDifference && xDifference == otherZDifference {
                xMultipliers = (0, -1, 0)
                yMultipliers = (0, 0, -1)
                zMultipliers = (1, 0, 0)
            } else if zDifference == otherXDifference && xDifference == otherYDifference && yDifference == otherZDifference {
                xMultipliers = (0, 0, 1)
                yMultipliers = (1, 0, 0)
                zMultipliers = (0, 1, 0)
            } else if zDifference == otherXDifference && xDifference == -otherYDifference && yDifference == -otherZDifference {
                xMultipliers = (0, 0, 1)
                yMultipliers = (-1, 0, 0)
                zMultipliers = (0, -1, 0)
            } else if zDifference == otherXDifference && xDifference == otherZDifference && yDifference == -otherYDifference {
                xMultipliers = (0, 0, 1)
                yMultipliers = (0, -1, 0)
                zMultipliers = (1, 0, 0)
            } else if zDifference == otherXDifference && xDifference == -otherZDifference && yDifference == otherYDifference {
                xMultipliers = (0, 0, 1)
                yMultipliers = (0, 1, 0)
                zMultipliers = (-1, 0, 0)
            } else if zDifference == -otherXDifference && xDifference == otherYDifference && yDifference == -otherZDifference {
                xMultipliers = (0, 0, -1)
                yMultipliers = (1, 0, 0)
                zMultipliers = (0, -1, 0)
            } else if zDifference == -otherXDifference && xDifference == -otherYDifference && yDifference == otherZDifference {
                xMultipliers = (0, 0, -1)
                yMultipliers = (-1, 0, 0)
                zMultipliers = (0, 1, 0)
            } else if zDifference == -otherXDifference && xDifference == otherZDifference && yDifference == otherYDifference {
                xMultipliers = (0, 0, -1)
                yMultipliers = (0, 1, 0)
                zMultipliers = (1, 0, 0)
            } else {
                xMultipliers = (0, 0, -1)
                yMultipliers = (0, -1, 0)
                zMultipliers = (-1, 0, 0)
            }
            
            let position = Point(x: otherScannerPoint1.x - xMultipliers.x * point1.x - xMultipliers.y * point1.y - xMultipliers.z * point1.z,
                                 y: otherScannerPoint1.y - yMultipliers.x * point1.x - yMultipliers.y * point1.y - yMultipliers.z * point1.z,
                                 z: otherScannerPoint1.z - zMultipliers.x * point1.x - zMultipliers.y * point1.y - zMultipliers.z * point1.z)
            
            let absoluteBeaconPoints = scannerPoints.map {
                Point(x: position.x + xMultipliers.x * $0.x + xMultipliers.y * $0.y + xMultipliers.z * $0.z,
                      y: position.y + yMultipliers.x * $0.x + yMultipliers.y * $0.y + yMultipliers.z * $0.z,
                      z: position.z + zMultipliers.x * $0.x + zMultipliers.y * $0.y + zMultipliers.z * $0.z)
            }
            
            scanners.append(Scanner(index: i, position: position, absoluteBeaconPoints: absoluteBeaconPoints, distances: scannerDistances))
            
            continue outerLoop
        }
    }
    
    stillToDo.append(i)
}


var points = Set<Point>()
for scanner in scanners {
    points.formUnion(scanner.absoluteBeaconPoints)
}

var largestManhattanDistance = Int.min
for (i, scanner) in scanners.enumerated() {
    for otherScanner in scanners[(i + 1)...] {
        largestManhattanDistance = max(largestManhattanDistance, scanner.position.manhattanDistance(to: otherScanner.position))
    }
}

print(largestManhattanDistance)
