import Foundation

// Just for correctly printing a number to a binary string representation
public extension String.StringInterpolation {
    enum Radix: Int {
        case binary = 2, octal = 8, decimal = 10, hex = 16
    }

    mutating func appendInterpolation<I: BinaryInteger>(_ value: I, radix: Radix, toWidth width: Int = 0) {
        var string = String(value, radix: radix.rawValue).uppercased()

        if string.count < width {
                string = String(repeating: "0", count: max(0, width - string.count)) + string
        }

        appendInterpolation(string)
    }
}


enum Packet {
    enum OperatorType: Int {
        case sum = 0
        case product, minimum, maximum
        case greaterThan = 5
        case lessThan, equalTo

        func value(for subPackets: [Packet]) -> Int {
            switch self {
            case .sum:
                return subPackets.reduce(0) { $0 + $1.value }
            case .product:
                return subPackets.reduce(1) { $0 * $1.value }
            case .minimum:
                return subPackets.min(by: { $0.value < $1.value })!.value
            case .maximum:
                return subPackets.max(by: { $0.value < $1.value })!.value
            case .greaterThan:
                return subPackets.first!.value > subPackets.last!.value ? 1 : 0
            case .lessThan:
                return subPackets.first!.value < subPackets.last!.value ? 1 : 0
            case .equalTo:
                return subPackets.first!.value == subPackets.last!.value ? 1 : 0
            }
        }
    }

    case literal(version: Int, number: Int)
    case op(version: Int, type: OperatorType, subPackets: [Packet])

    var versionSum: Int {
        switch self {
        case let .literal(version, _):
            return version
        case let .op(version, _, subPackets):
            return version + subPackets.reduce(0) { $0 + $1.versionSum }
        }
    }

    var value: Int {
        switch self {
        case let .literal(_, number):
            return number
        case let .op(_, type, subPackets):
            return type.value(for: subPackets)
        }
    }
}


let url = Bundle.module.url(forResource: "day16", withExtension: "txt")!
let fileContents = try! String(contentsOf: url, encoding: .utf8)


let lines = fileContents.split(separator: "\n")

let binaryRepresentation = lines.first!.reduce("") { $0 + "\(Int(String($1), radix: 16)!, radix: .binary, toWidth: 4)" }


func parsePacket(startIndex current: inout String.Index) -> Packet {
    let versionStart = current
    current = binaryRepresentation.index(current, offsetBy: 3)

    let version = Int(binaryRepresentation[versionStart..<current], radix: 2)!

    let typeIDStart = current
    current = binaryRepresentation.index(current, offsetBy: 3)

    let typeID = Int(binaryRepresentation[typeIDStart..<current], radix: 2)!

    var packet: Packet
    switch typeID {
    case 4:
        var number = 0
        while binaryRepresentation[current] == "1" {
            binaryRepresentation.formIndex(after: &current)

            let subNumberStart = current
            current = binaryRepresentation.index(current, offsetBy: 4)

            let subNumber = Int(binaryRepresentation[subNumberStart..<current], radix: 2)!
            number <<= 4
            number += subNumber
        }

        binaryRepresentation.formIndex(after: &current)

        let lastSubNumberStart = current
        current = binaryRepresentation.index(current, offsetBy: 4)

        let lastSubNumber = Int(binaryRepresentation[lastSubNumberStart..<current], radix: 2)!
        number <<= 4
        number += lastSubNumber

        packet = .literal(version: version, number: number)
    default:
        var subPackets = [Packet]()
        if binaryRepresentation[current] == "0" {
            binaryRepresentation.formIndex(after: &current)

            let lengthStart = current
            current = binaryRepresentation.index(current, offsetBy: 15)

            let length = Int(binaryRepresentation[lengthStart..<current], radix: 2)!

            let subPacketStart = current
            while binaryRepresentation.distance(from: subPacketStart, to: current) < length {
                subPackets.append(parsePacket(startIndex: &current))
            }
        } else {
            binaryRepresentation.formIndex(after: &current)

            let subPacketCountStart = current
            current = binaryRepresentation.index(current, offsetBy: 11)

            let subPacketCount = Int(binaryRepresentation[subPacketCountStart..<current], radix: 2)!

            for _ in 0..<subPacketCount {
                subPackets.append(parsePacket(startIndex: &current))
            }
        }

        packet = .op(version: version, type: Packet.OperatorType(rawValue: typeID)!, subPackets: subPackets)
    }

    return packet
}

var startIndex = binaryRepresentation.startIndex
let packet = parsePacket(startIndex: &startIndex)

print(packet.value)
