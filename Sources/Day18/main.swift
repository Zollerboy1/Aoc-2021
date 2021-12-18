import Foundation

enum Number: CustomStringConvertible {
    indirect case pair(left: Number, right: Number)
    case regular(Int)
    
    
    static func parse<S>(from string: S, startingAt currentIndex: inout S.Index) -> Number where S: StringProtocol {
        switch (string[currentIndex]) {
        case "[":
            string.formIndex(after: &currentIndex)
            
            let left = parse(from: string, startingAt: &currentIndex)
            
            assert(string[currentIndex] == ",")
            
            string.formIndex(after: &currentIndex)
            
            let right = parse(from: string, startingAt: &currentIndex)
            
            assert(string[currentIndex] == "]")
            
            string.formIndex(after: &currentIndex)
            
            return .pair(left: left, right: right)
        default:
            var endIndex = currentIndex
            while string[endIndex].isNumber {
                string.formIndex(after: &endIndex)
            }
            
            let integer = Int(string[currentIndex..<endIndex])!
            
            currentIndex = endIndex
            
            return .regular(integer)
        }
    }
    
    
    static func +(lhs: Number, rhs: Number) -> Number {
        return .pair(left: lhs, right: rhs)
    }
    
    
    func nextExplosion(depth: Int) -> (replacement: Number, exploded: (left: Int?, right: Int?)?, tookAction: Bool) {
        switch self {
        case let .pair(left, right):
            if depth == 4 {
                if case let .regular(leftInteger) = left,
                   case let .regular(rightInteger) = right {
                    return (.regular(0), (leftInteger, rightInteger), true)
                } else {
                    fatalError()
                }
            } else {
                var (leftReplacement, exploded, tookAction) = left.nextExplosion(depth: depth + 1)
                
                var rightReplacement: Number
                if tookAction {
                    if let exploded = exploded {
                        if let rightNumber = exploded.right {
                            rightReplacement = right.addRightExploded(rightNumber)
                        } else {
                            rightReplacement = right
                        }
                        
                        if let leftNumber = exploded.left {
                            return (.pair(left: leftReplacement, right: rightReplacement), (leftNumber, nil), true)
                        }
                    } else {
                        rightReplacement = right
                    }
                    
                    return (.pair(left: leftReplacement, right: rightReplacement), nil, true)
                } else {
                    let (rightReplacement, exploded, tookAction) = right.nextExplosion(depth: depth + 1)
                    
                    if tookAction {
                        if let exploded = exploded {
                            if let leftNumber = exploded.left {
                                leftReplacement = leftReplacement.addLeftExploded(leftNumber)
                            }
                            
                            if let rightNumber = exploded.right {
                                return (.pair(left: leftReplacement, right: rightReplacement), (nil, rightNumber), true)
                            }
                        }
                        
                        return (.pair(left: leftReplacement, right: rightReplacement), nil, true)
                    }
                    
                    return (.pair(left: leftReplacement, right: rightReplacement), nil, false)
                }
            }
        case .regular:
            return (self, nil, false)
        }
    }
    
    var nextSplit: (replacement: Number, tookAction: Bool) {
        switch self {
        case let .pair(left, right):
            let (leftReplacement, tookAction) = left.nextSplit
            
            if tookAction {
                return (.pair(left: leftReplacement, right: right), true)
            } else {
                let (rightReplacement, tookAction) = right.nextSplit
                
                return (.pair(left: leftReplacement, right: rightReplacement), tookAction)
            }
        case let .regular(integer):
            if integer >= 10 {
                return (.pair(left: .regular(integer / 2), right: .regular(integer / 2 + (integer % 2 == 0 ? 0 : 1))), true)
            } else {
                return (self, false)
            }
        }
    }
    
    func addRightExploded(_ integer: Int) -> Number {
        switch self {
        case let .pair(left, right):
            return .pair(left: left.addRightExploded(integer), right: right)
        case let .regular(oldInteger):
            return .regular(oldInteger + integer)
        }
    }
    
    func addLeftExploded(_ integer: Int) -> Number {
        switch self {
        case let .pair(left, right):
            return .pair(left: left, right: right.addLeftExploded(integer))
        case let .regular(oldInteger):
            return .regular(oldInteger + integer)
        }
    }
    
    
    var magnitude: Int {
        switch self {
        case let .pair(left, right):
            return left.magnitude * 3 + right.magnitude * 2
        case let .regular(integer):
            return integer
        }
    }
    
    
    var description: String {
        switch self {
        case let .pair(left, right):
            return "[" + left.description + "," + right.description + "]"
        case let .regular(integer):
            return "\(integer)"
        }
    }
}

let url = Bundle.module.url(forResource: "day18", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")


let numbers: [Number] = lines.map {
    var index = $0.startIndex
    
    let number = Number.parse(from: $0, startingAt: &index)
    
    assert(index == $0.endIndex)
    
    return number
}


var largestMagnitude = Int.min
for (i, a) in numbers.enumerated() {
    for b in numbers[(i + 1)...] {
        var number = a + b
        
        var reduce = true
        while reduce {
            while reduce {
                (number, _ , reduce) = number.nextExplosion(depth: 0)
            }
            
            (number, reduce) = number.nextSplit
        }
        
        largestMagnitude = max(largestMagnitude, number.magnitude)
        
        
        number = b + a
        
        reduce = true
        while reduce {
            while reduce {
                (number, _ , reduce) = number.nextExplosion(depth: 0)
            }
            
            (number, reduce) = number.nextSplit
        }
        
        largestMagnitude = max(largestMagnitude, number.magnitude)
    }
}

print(largestMagnitude)
