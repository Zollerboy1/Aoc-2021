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
        if other.xRange.contains(xRange) {
            if other.yRange.contains(yRange) {
                if other.zRange.contains(zRange) {
                    return []
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [Cuboid(xRange: xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)]
                } else {
                    return [Cuboid(xRange: xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))]
                }
            } else if yRange.lowerBound < other.yRange.lowerBound && yRange.upperBound > other.yRange.upperBound {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else if other.yRange.lowerBound <= yRange.lowerBound {
                if other.zRange.contains(zRange) {
                    return [Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange)]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: other.zRange)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else {
                if other.zRange.contains(zRange) {
                    return [Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange)]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound),
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: other.zRange)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            }
        } else if xRange.lowerBound < other.xRange.lowerBound && xRange.upperBound > other.xRange.upperBound {
            if other.yRange.contains(yRange) {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: other.xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else if yRange.lowerBound < other.yRange.lowerBound && yRange.upperBound > other.yRange.upperBound {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: other.xRange, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else if other.yRange.lowerBound <= yRange.lowerBound {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: other.xRange, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            }
        } else if other.xRange.lowerBound <= xRange.lowerBound {
            if other.yRange.contains(yRange) {
                if other.zRange.contains(zRange) {
                    return [Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange)]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: other.zRange)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else if yRange.lowerBound < other.yRange.lowerBound && yRange.upperBound > other.yRange.upperBound {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: other.yRange, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: other.yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: other.yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: other.yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else if other.yRange.lowerBound <= yRange.lowerBound {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: (other.xRange.upperBound + 1)...xRange.upperBound, yRange: yRange, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...other.xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            }
        } else {
            if other.yRange.contains(yRange) {
                if other.zRange.contains(zRange) {
                    return [Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange)]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: xRange, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound),
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: other.zRange)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else if yRange.lowerBound < other.yRange.lowerBound && yRange.upperBound > other.yRange.upperBound {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: other.yRange, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: other.yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: other.yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: xRange, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: other.yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else if other.yRange.lowerBound <= yRange.lowerBound {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: (other.yRange.upperBound + 1)...yRange.upperBound, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...other.yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            } else {
                if other.zRange.contains(zRange) {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange)
                    ]
                } else if zRange.lowerBound < other.zRange.lowerBound && zRange.upperBound > other.zRange.upperBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1)),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else if other.zRange.lowerBound <= zRange.lowerBound {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: (other.zRange.upperBound + 1)...zRange.upperBound)
                    ]
                } else {
                    return [
                        Cuboid(xRange: xRange.lowerBound...(other.xRange.lowerBound - 1), yRange: yRange, zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: yRange.lowerBound...(other.yRange.lowerBound - 1), zRange: zRange),
                        Cuboid(xRange: other.xRange.lowerBound...xRange.upperBound, yRange: other.yRange.lowerBound...yRange.upperBound, zRange: zRange.lowerBound...(other.zRange.lowerBound - 1))
                    ]
                }
            }
        }
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
