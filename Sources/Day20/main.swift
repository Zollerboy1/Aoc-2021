import Foundation

let url = Bundle.module.url(forResource: "day20", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")
