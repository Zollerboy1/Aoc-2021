import RealModule

enum Location: Int {
    case a = 0, b, c, d
    case empty
}

struct State: Hashable {
    let sideRooms: [[Location]]

    let hallway: [Location]
}


func memoize<Input: Hashable, Output>(_ function: @escaping (Input) -> Output) -> (Input) -> Output {
    var cache = [Input: Output]()

    return { input in
        if let cached = cache[input] {
            return cached
        }

        let result = function(input)
        cache[input] = result
        return result
    }
}


var memoizedRecursion = memoize(recursion(state:))

func recursion(state: State) -> Int? {
    var minimumEnergy: Int?

    var finished = !state.hallway.contains { $0 != .empty }
    if finished {
        for (i, sideRoom) in state.sideRooms.enumerated() {
            if sideRoom.contains(where: { $0 != Location(rawValue: i) }) {
                finished = false
                break
            }
        }

        if finished {
            return 0
        }
    }

    for (hallwayIndex, amphipod) in state.hallway.enumerated().filter({ $0.element != .empty }) {
        if !state.sideRooms[amphipod.rawValue].contains(where: { $0 != amphipod && $0 != .empty })
            && !state.hallway[min(hallwayIndex + 1, 2 + 2 * amphipod.rawValue)...max(hallwayIndex - 1, 2 + 2 * amphipod.rawValue)].contains(where: { $0 != .empty }) {
            let newIndex = state.sideRooms[amphipod.rawValue].firstIndex(where: { $0 == .empty })!
            var newSideRooms = state.sideRooms
            newSideRooms[amphipod.rawValue][newIndex] = amphipod

            var newHallway = state.hallway
            newHallway[hallwayIndex] = .empty

            let energy = (4 - newIndex + Int(((2 + 2 * amphipod.rawValue) - hallwayIndex).magnitude)) * Int(Double.pow(10, amphipod.rawValue))

            if let nextEnergy = memoizedRecursion(State(sideRooms: newSideRooms, hallway: newHallway)) {
                minimumEnergy = min(minimumEnergy ?? Int.max, energy + nextEnergy)
            }
        }
    }

    for (i, sideRoom) in state.sideRooms.enumerated().filter({ i, e in e.contains { $0 != Location(rawValue: i) && $0 != .empty } }) {
        if let topAmphipodIndex = sideRoom.lastIndex(where: { $0 != .empty }) {
            let topAmphipod = state.sideRooms[i][topAmphipodIndex]
            if i != topAmphipod.rawValue
                && !state.sideRooms[topAmphipod.rawValue].contains(where: { $0 != topAmphipod && $0 != .empty })
                && !state.hallway[(2 + 2 * min(i, topAmphipod.rawValue))...(2 + 2 * max(i, topAmphipod.rawValue))].contains(where: { $0 != .empty }) {
                let newIndex = state.sideRooms[topAmphipod.rawValue].firstIndex(where: { $0 == .empty })!
                var newSideRooms = state.sideRooms
                newSideRooms[i][topAmphipodIndex] = .empty
                newSideRooms[topAmphipod.rawValue][newIndex] = topAmphipod

                let energy = (8 - topAmphipodIndex + Int((i - topAmphipod.rawValue).magnitude) * 2 - newIndex) * Int(Double.pow(10, topAmphipod.rawValue))

                if let nextEnergy = memoizedRecursion(State(sideRooms: newSideRooms, hallway: state.hallway)) {
                    minimumEnergy = min(minimumEnergy ?? Int.max, energy + nextEnergy)
                }
            }
            for hallwayIndex in [0, 1, 3, 5, 7, 9, 10].filter({ !state.hallway[min($0, 2 + 2 * i)...max($0, 2 + 2 * i)].contains { $0 != .empty } }) {
                var newSideRooms = state.sideRooms
                newSideRooms[i][topAmphipodIndex] = .empty

                var newHallway = state.hallway
                newHallway[hallwayIndex] = topAmphipod

                let energy = (4 - topAmphipodIndex + Int(((2 + 2 * i) - hallwayIndex).magnitude)) * Int(Double.pow(10, topAmphipod.rawValue))

                if let nextEnergy = memoizedRecursion(State(sideRooms: newSideRooms, hallway: newHallway)) {
                    minimumEnergy = min(minimumEnergy ?? Int.max, energy + nextEnergy)
                }
            }
        }
    }

    return minimumEnergy
}


let energy = memoizedRecursion(State(sideRooms: [[.c, .d, .d, .c], [.a, .b, .c, .a], [.d, .a, .b, .b], [.b, .c, .a, .d]], hallway: .init(repeating: .empty, count: 11)))!

print(energy)
