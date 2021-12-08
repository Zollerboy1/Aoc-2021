import Foundation

let url = Bundle.module.url(forResource: "day8", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let patterns = lines.map { $0.split(separator: " ") }
let finalPatterns = patterns.map { $0.split(separator: "|") }


var count = 0
for finalPattern in finalPatterns {
    let one = finalPattern[0].first(where: { $0.count == 2 })!
    let four = finalPattern[0].first(where: { $0.count == 4 })!
    let seven = finalPattern[0].first(where: { $0.count == 3 })!
    
    let three = finalPattern[0].first(where: { pattern in
        if pattern.count == 5 {
            for char in seven {
                if !pattern.contains(char) {
                    return false
                }
            }
            
            var fourCount = 0
            for char in four.filter({ !one.contains($0) }) {
                if pattern.contains(char) {
                    fourCount += 1
                }
            }
            
            guard fourCount == 1 else { return false }
            
            return true
        }
        return false
    })!
    
    let top = seven.first(where: { !one.contains($0) })!
    
    let bottom = three.first(where: { !seven.contains($0) && !four.contains($0) })!
    
    let middle = three.first(where: { !seven.contains($0) && four.contains($0) })!
    
    let leftTop = four.first(where: { !one.contains($0) && $0 != middle })!
    
    let leftBottom = "abcdefg".first(where: { !seven.contains($0) && $0 != middle && $0 != bottom && $0 != leftTop })!
    
    let two = finalPattern[0].first(where: { pattern in
        if pattern.count == 5 {
            if pattern.contains(top) && pattern.contains(middle) && pattern.contains(bottom) && pattern.contains(leftBottom) {
                return true
            }
        }
        return false
    })!
    
    let rightTop = two.first(where: { $0 != top && $0 != middle && $0 != bottom && $0 != leftBottom })!
    
    let rightBottom = one.first(where: { $0 != rightTop })!
    
    var value = 0
    
    for pattern in finalPattern[1] {
        if pattern.count == 2 {
            value += 1
        } else if pattern.count == 3 {
            value += 7
        } else if pattern.count == 4 {
            value += 4
        } else if pattern.count == 5 {
            if pattern.contains(leftTop) {
                value += 5
            } else if pattern.contains(rightBottom) {
                value += 3
            } else {
                value += 2
            }
        } else if pattern.count == 6 {
            if pattern.contains(middle) {
                if pattern.contains(rightTop) {
                    value += 9
                } else {
                    value += 6
                }
            } else {
                value += 0
            }
        } else {
            value += 8
        }
        
        value *= 10
    }
    
    count += value / 10
}


print(count)
