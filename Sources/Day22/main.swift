import Foundation

extension ClosedRange {
    func contains(_ other: ClosedRange<Bound>) -> Bool {
        return lowerBound <= other.lowerBound && upperBound >= other.upperBound
    }
}

struct Cuboid {
    let xRange, yRange, zRange: ClosedRange<Int>
    
    
    func intersects(with other: Cuboid) -> Bool {
        return xRange.overlaps(other.xRange) && yRange.overlaps(other.yRange) && zRange.overlaps(other.zRange)
    }
    
    func subtracting(_ other: Cuboid) -> [Cuboid] {
        let intersection = Cuboid(xRange: xRange.clamped(to: other.xRange), yRange: yRange.clamped(to: other.yRange), zRange: zRange.clamped(to: other.zRange))
        
        var difference = [Cuboid]()
        
        if intersection.xRange.lowerBound > xRange.lowerBound {
            difference.append(Cuboid(xRange: xRange.lowerBound...(intersection.xRange.lowerBound - 1), yRange: yRange, zRange: zRange))
        }
        
        if intersection.xRange.upperBound < xRange.upperBound {
            difference.append(Cuboid(xRange: (intersection.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange))
        }
        
        if intersection.yRange.lowerBound > yRange.lowerBound {
            difference.append(Cuboid(xRange: intersection.xRange, yRange: yRange.lowerBound...(intersection.yRange.lowerBound - 1), zRange: zRange))
        }
        
        if intersection.yRange.upperBound < yRange.upperBound {
            difference.append(Cuboid(xRange: intersection.xRange, yRange: (intersection.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange))
        }
        
        if intersection.zRange.lowerBound > zRange.lowerBound {
            difference.append(Cuboid(xRange: intersection.xRange, yRange: intersection.yRange, zRange: zRange.lowerBound...(intersection.zRange.lowerBound - 1)))
        }
        
        if intersection.zRange.upperBound < zRange.upperBound {
            difference.append(Cuboid(xRange: intersection.xRange, yRange: intersection.yRange, zRange: (intersection.zRange.upperBound + 1)...zRange.upperBound))
        }
        
        return difference
    }
}

let url = Bundle.module.url(forResource: "day22", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")


let steps: [(turnOn: Bool, cuboid: Cuboid)] = lines.map { line in
    var line = line
    
    let turnOn = line.hasPrefix("on")
    
    line = line.drop { !$0.isNumber && $0 != "-" }
    
    let xStart = Int(line.prefix(while: { $0.isNumber || $0 == "-" }))!
    line = line.drop { $0.isNumber || $0 == "-" }
    
    line = line.drop { !$0.isNumber && $0 != "-" }
    
    let xEnd = Int(line.prefix(while: { $0.isNumber || $0 == "-" }))!
    line = line.drop { $0.isNumber || $0 == "-" }
    
    line = line.drop { !$0.isNumber && $0 != "-" }
    
    let yStart = Int(line.prefix(while: { $0.isNumber || $0 == "-" }))!
    line = line.drop { $0.isNumber || $0 == "-" }
    
    line = line.drop { !$0.isNumber && $0 != "-" }
    
    let yEnd = Int(line.prefix(while: { $0.isNumber || $0 == "-" }))!
    line = line.drop { $0.isNumber || $0 == "-" }
    
    line = line.drop { !$0.isNumber && $0 != "-" }
    
    let zStart = Int(line.prefix(while: { $0.isNumber || $0 == "-" }))!
    line = line.drop { $0.isNumber || $0 == "-" }
    
    line = line.drop { !$0.isNumber && $0 != "-" }
    
    let zEnd = Int(line.prefix(while: { $0.isNumber || $0 == "-" }))!
    
    return (turnOn, Cuboid(xRange: xStart...xEnd, yRange: yStart...yEnd, zRange: zStart...zEnd))
}


var reactor = [Cuboid]()

for (turnOn, cuboid) in steps {
    if turnOn {
        var toTurnOn = [cuboid]
        for alreadyOn in reactor {
            var i = 0
            while i < toTurnOn.count {
                let nextCuboid = toTurnOn[i]
                if nextCuboid.intersects(with: alreadyOn) {
                    let nextCuboids = nextCuboid.subtracting(alreadyOn)
                    
                    toTurnOn.replaceSubrange(i...i, with: nextCuboids)
                    i += nextCuboids.count
                } else {
                    i += 1
                }
            }
        }
        
        reactor.append(contentsOf: toTurnOn)
    } else {
        var i = 0
        while i < reactor.count {
            let nextCuboid = reactor[i]
            if nextCuboid.intersects(with: cuboid) {
                let nextCuboids = nextCuboid.subtracting(cuboid)
                
                reactor.replaceSubrange(i...i, with: nextCuboids)
                i += nextCuboids.count
            } else {
                i += 1
            }
        }
    }
}

var cubeCount = 0
for cuboid in reactor {
    cubeCount += cuboid.xRange.count * cuboid.yRange.count * cuboid.zRange.count
}

print(cubeCount)
