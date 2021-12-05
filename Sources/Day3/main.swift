import Foundation

let url = Bundle.module.url(forResource: "day3", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)

let lines = fileContents.split(separator: "\n").compactMap { Int($0, radix: 2) }

let lineLength = 12

var oxygenGeneratorNumbers = lines
var cO2ScrubberNumbers = lines

for i in 0..<lineLength {
    if oxygenGeneratorNumbers.count > 1 {
        let count = Double(oxygenGeneratorNumbers.count)
        let bitCount = oxygenGeneratorNumbers.reduce(0, {
            $0 + ($1 & (1 << (lineLength - 1 - i)) == 0 ? 0 : 1)
        })
        oxygenGeneratorNumbers = oxygenGeneratorNumbers.filter { Double(bitCount) > count / 2 ? ($0 & (1 << (lineLength - 1 - i)) != 0) : ($0 & (1 << (lineLength - 1 - i)) == 0) }
    }
    if cO2ScrubberNumbers.count > 1 {
        let count = Double(cO2ScrubberNumbers.count)
        let bitCount = cO2ScrubberNumbers.reduce(0, { $0 + ($1 & (1 << (lineLength - 1 - i)) == 0 ? 0 : 1) })
        cO2ScrubberNumbers = cO2ScrubberNumbers.filter { Double(bitCount) < count / 2 ? ($0 & (1 << (lineLength - 1 - i)) != 0) : ($0 & (1 << (lineLength - 1 - i)) == 0) }
    }
}

print((oxygenGeneratorNumbers.first! + 1) * cO2ScrubberNumbers.first!)
//                                   ^^^
//                                  Here
