import Foundation

let url = Bundle.module.url(forResource: "day20", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let enhancementAlgorithm = lines.first!.map { $0 == "#" }

var inputImage = lines[1...].map { $0.map { $0 == "#" } }


var outputImage = [[Bool]](repeating: [Bool](repeating: false, count: inputImage[0].count + 2), count: inputImage.count + 2)
for turn in 0..<50 {
    for i in 0..<outputImage.count {
        for j in 0..<outputImage[0].count {
            var inputPixelValue = 0
            for iOffset in -1...1 {
                for jOffset in -1...1 {
                    let pixelI = i + iOffset
                    let pixelJ = j + jOffset
                    
                    if pixelI <= 0 || pixelI >= inputImage.count + 1 || pixelJ <= 0 || pixelJ >= inputImage[0].count + 1 {
                        inputPixelValue <<= 1
                        inputPixelValue += turn % 2
                    } else {
                        inputPixelValue <<= 1
                        inputPixelValue += inputImage[pixelI - 1][pixelJ - 1] ? 1 : 0
                    }
                }
            }
            
            outputImage[i][j] = enhancementAlgorithm[inputPixelValue]
        }
    }
    inputImage = outputImage
    outputImage = [[Bool]](repeating: [Bool](repeating: false, count: inputImage[0].count + 2), count: inputImage.count + 2)
}

print(inputImage.flatMap({ $0 }).reduce(0) { $0 + ($1 ? 1 : 0) })
