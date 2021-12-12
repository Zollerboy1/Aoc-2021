import Foundation

let url = Bundle.module.url(forResource: "day12", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let edges = lines.map { $0.split(separator: "-") }.map { ($0[0], $0[1]) }

let vertices: Set<Substring> = edges.reduce(into: .init()) {
    $0.insert($1.0)
    $0.insert($1.1)
}

let adjacencyList = [Substring: [Substring]](uniqueKeysWithValues: vertices.map { vertex in
    (vertex, edges.filter({ $0 == vertex || $1 == vertex }).map { $0 == vertex ? $1 : $0 })
})

func visit(vertex: Substring, alreadyVisited: [Substring: Int], visitedOneTwice: Bool) -> Int {
    if vertex == "end" {
        return 1
    } else {
        var count = 0
        
        var alreadyVisited = alreadyVisited
        if let visitedNumber = alreadyVisited[vertex] {
            alreadyVisited[vertex] = visitedNumber + 1
        } else {
            alreadyVisited[vertex] = 1
        }
        
        for nextVertex in adjacencyList[vertex]! {
            if !nextVertex.first!.isLowercase {
                count += visit(vertex: nextVertex, alreadyVisited: alreadyVisited, visitedOneTwice: visitedOneTwice)
            } else {
                if alreadyVisited[nextVertex] == nil {
                    count += visit(vertex: nextVertex, alreadyVisited: alreadyVisited, visitedOneTwice: visitedOneTwice)
                } else if !visitedOneTwice && alreadyVisited[nextVertex] == 1 {
                    count += visit(vertex: nextVertex, alreadyVisited: alreadyVisited, visitedOneTwice: true)
                }
            }
        }
        
        return count
    }
}

let count = visit(vertex: "start", alreadyVisited: ["start": 1], visitedOneTwice: false)

print(count)
