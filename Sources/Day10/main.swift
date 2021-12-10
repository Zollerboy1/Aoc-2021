import Foundation

let url = Bundle.module.url(forResource: "day10", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")


class Parser<S: StringProtocol> {
    enum Error: Swift.Error {
        case discarded
    }
    
    let string: S
    var current: S.Index
    
    let endTypes: [Character: (Character, Int)] = [
        "(": (")", 1),
        "[": ("]", 2),
        "{": ("}", 3),
        "<": (">", 4)
    ]
    
    init(_ string: S) {
        self.string = string
        self.current = string.startIndex
    }
    
    func parse(parenType: Character) throws -> Int {
        self.string.formIndex(after: &self.current)
        
        let subParse = try self.parse()
        
        if subParse != 0 {
            return subParse * 5 + self.endTypes[parenType]!.1
        }
        
        if self.current == self.string.endIndex {
            return self.endTypes[parenType]!.1
        }
        
        guard self.string[self.current] == self.endTypes[parenType]!.0 else {
            throw Error.discarded
        }
        
        self.string.formIndex(after: &self.current)
        
        return 0
    }
    
    
    func parse() throws -> Int {
        while current != string.endIndex && self.endTypes.keys.contains(self.string[self.current]) {
            let parsed = try self.parse(parenType: self.string[self.current])
            
            if parsed != 0 {
                return parsed
            }
        }
        
        return 0
    }
}

var scores = [Int]()

for line in lines {
    let parser = Parser(line)
    
    if let score = try? parser.parse(), score != 0 {
        scores.append(score)
    }
}

scores.sort()

print(scores[scores.count / 2])
