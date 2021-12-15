import Foundation

struct PriorityQueue {
    private var heap: [Pair]
    private var map: [Int]
    private var size: Int

    init(heap: [Pair], map: [Int]) {
        self.heap = heap
        self.map = map
        self.size = heap.count
    }

    var isEmpty: Bool { size == 0 }

    mutating func extractMin() -> Pair {
        let min = heap[0]
        size -= 1
        heap[0] = heap[size]

        map[min.index] = -1;
        map[heap[0].index] = 0;

        restoreHeapDown(i: 0)

        return min
    }

    mutating func decreaseKey(index: Int, newValue: Int) {
        let i = map[index]

        heap[i].value = newValue;

        restoreHeapUp(i: i)
    }



    private mutating func restoreHeapDown(i: Int) {
        var i = i

        while (2 * i + 1 < size) {
            var j = 2 * i + 1

            if (j + 1 < size && heap[j] > heap[j + 1]) { j += 1 }
            if (heap[i] <= heap[j]) { return }

            swap(i, j)

            i = j
        }
    }

    private mutating func restoreHeapUp(i: Int) {
        var i = i

        while (i > 0) {
            var j = (i - 1) / 2

            if (heap[j] <= heap[i]) { return }

            swap(i, j)

            i = j
        }
    }

    private mutating func swap(_ i: Int, _ j: Int) {
        let temp = heap[i]
        heap[i] = heap[j]
        heap[j] = temp

        map[heap[i].index] = i
        map[heap[j].index] = j
    }
}

struct Pair: Comparable {
    let index: Int
    var value: Int

    init(index: Int, value: Int) {
        self.index = index
        self.value = value
    }

    public static func ==(lhs: Pair, rhs: Pair) -> Bool {
        lhs.value == rhs.value
    }

    public static func <(lhs: Pair, rhs: Pair) -> Bool {
        lhs.value < rhs.value
    }
}

let url = Bundle.module.url(forResource: "day15", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let smallMatrix = lines.map { $0.map { Int(String($0))! } }

var matrix = [[Int]](repeating: [Int](repeating: 0, count: smallMatrix[0].count * 5), count: smallMatrix.count * 5)
for i in 0..<5 {
    for j in 0..<5 {
        for (smallI, smallRow) in smallMatrix.enumerated() {
            for (smallJ, risk) in smallRow.enumerated() {
                let newI = i * smallMatrix.count + smallI
                let newJ = j * smallMatrix[0].count + smallJ

                var newRisk = risk + i + j
                if (newRisk > 9) {
                    newRisk = newRisk % 10 + 1
                }

                matrix[newI][newJ] = newRisk
            }
        }
    }
}

let width = matrix[0].count
let height = matrix.count


var d = [Int](repeating: .max, count: height * width)
d[0] = 0

let heap = (0..<(height * width)).map { $0 == 0 ? Pair(index: 0, value: 0) : Pair(index: $0, value: .max) }
let map = (0..<(height * width)).map { $0 }

var queue = PriorityQueue(heap: heap, map: map)

var S: Set<Int> = []

while S.count != height * width {
    let v = queue.extractMin()

    if (v.index == (height * width) - 1) {
        print(v.value)
        break
    }

    S.insert(v.index)

    var adjacentIndices = [Int]()

    if (v.index >= width) {
        adjacentIndices.append(v.index - width)
    }

    if (v.index % width != 0) {
        adjacentIndices.append(v.index - 1)
    }

    if (v.index % width != width - 1) {
        adjacentIndices.append(v.index + 1)
    }

    if (v.index / width < height - 1) {
        adjacentIndices.append(v.index + width)
    }

    for adjacentIndex in adjacentIndices {
        if !S.contains(adjacentIndex) {
            d[adjacentIndex] = min(d[adjacentIndex], d[v.index] + matrix[adjacentIndex / width][adjacentIndex % width])
            queue.decreaseKey(index: adjacentIndex, newValue: d[adjacentIndex])
        }
    }
}
