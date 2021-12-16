import Foundation

// Just for correctly printing a number to a binary string representation
extension String.StringInterpolation {
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


typealias Program = [UInt8]


enum OPCode: UInt8, CustomStringConvertible {
    case constant
    case sum
    case product
    case minimum
    case maximum
    case greaterThan
    case lessThan
    case equalTo
    case print


    var description: String {
        switch self {
        case .constant:
            return "CONSTANT"
        case .sum:
            return "SUM"
        case .product:
            return "PRODUCT"
        case .minimum:
            return "MINIMUM"
        case .maximum:
            return "MAXIMUM"
        case .greaterThan:
            return "GRATER_THAN"
        case .lessThan:
            return "LESS_THAN"
        case .equalTo:
            return "EQUAL_TO"
        case .print:
            return "PRINT"
        }
    }
}

enum Packet: CustomStringConvertible {
    enum OperatorType: Int, CustomStringConvertible {
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


        var opCode: OPCode {
            switch self {
            case .sum:
                return .sum
            case .product:
                return .product
            case .minimum:
                return .minimum
            case .maximum:
                return .maximum
            case .greaterThan:
                return .greaterThan
            case .lessThan:
                return .lessThan
            case .equalTo:
                return .equalTo
            }
        }


        var description: String {
            switch self {
            case .sum:
                return "sum"
            case .product:
                return "product"
            case .minimum:
                return "minimum"
            case .maximum:
                return "maximum"
            case .greaterThan:
                return "greaterThan"
            case .lessThan:
                return "lessThan"
            case .equalTo:
                return "equalTo"
            }
        }
    }

    case literal(version: Int, number: UInt)
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
            return Int(number)
        case let .op(_, type, subPackets):
            return type.value(for: subPackets)
        }
    }


    func addInstructions(to program: inout Program) {
        switch self {
        case let .literal(_, number):
            program.append(OPCode.constant.rawValue)
            program.append(UInt8((number >> 56) & 0xFF))
            program.append(UInt8((number >> 48) & 0xFF))
            program.append(UInt8((number >> 40) & 0xFF))
            program.append(UInt8((number >> 32) & 0xFF))
            program.append(UInt8((number >> 24) & 0xFF))
            program.append(UInt8((number >> 16) & 0xFF))
            program.append(UInt8((number >> 8) & 0xFF))
            program.append(UInt8(number & 0xFF))
        case let .op(_, type, subPackets):
            subPackets.first!.addInstructions(to: &program)
            for subPacket in subPackets.dropFirst() {
                subPacket.addInstructions(to: &program)

                program.append(type.opCode.rawValue)
            }
        }
    }


    var description: String {
        toString(depth: 0)
    }


    func toString(depth: Int) -> String {
        let indentation = String(repeating: " ", count: depth * 2)
        var string = indentation

        switch self {
        case let .literal(_, number):
            string += "literal(\(number))"
        case let .op(_, type, subPackets):
            string += "operator{\(type)}(\n"

            string += subPackets.first!.toString(depth: depth + 1)
            for subPacket in subPackets.dropFirst() {
                string += ",\n"
                string += subPacket.toString(depth: depth + 1)
            }

            string += "\n" + indentation + ")"
        }

        return string
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
        var number: UInt = 0
        while binaryRepresentation[current] == "1" {
            binaryRepresentation.formIndex(after: &current)

            let subNumberStart = current
            current = binaryRepresentation.index(current, offsetBy: 4)

            let subNumber = UInt(binaryRepresentation[subNumberStart..<current], radix: 2)!
            number <<= 4
            number += subNumber
        }

        binaryRepresentation.formIndex(after: &current)

        let lastSubNumberStart = current
        current = binaryRepresentation.index(current, offsetBy: 4)

        let lastSubNumber = UInt(binaryRepresentation[lastSubNumberStart..<current], radix: 2)!
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


var program = Program()
packet.addInstructions(to: &program)

program.append(OPCode.print.rawValue)

var programIterator = program.makeIterator()

//while let encodedOPCode = programIterator.next(),
//      let opCode = OPCode(rawValue: encodedOPCode) {
//    var string = "\(opCode.rawValue, radix: .hex, toWidth: 2) "
//    switch opCode {
//    case .constant:
//        var number: UInt = 0
//        for _ in 0..<8 {
//            let subNumber = programIterator.next()!
//
//            string += "\(subNumber, radix: .hex, toWidth: 2) "
//
//            number <<= 8
//            number += UInt(subNumber)
//        }
//        string += "   "
//        string += opCode.description
//        string += " \(number)"
//    default:
//        string += String(repeating: " ", count: 9 * 3)
//        string += opCode.description
//    }
//
//    print(string)
//}
//
//print("")


var stack = [UInt]()

//programIterator = program.makeIterator()
while let encodedOPCode = programIterator.next(),
      let opCode = OPCode(rawValue: encodedOPCode) {
    switch opCode {
    case .constant:
        var number: UInt = 0
        for _ in 0..<8 {
            number <<= 8
            number += UInt(programIterator.next()!)
        }
        stack.append(number)
    case .sum:
        let second = stack.popLast()!
        let first = stack.popLast()!
        stack.append(first + second)
    case .product:
        let second = stack.popLast()!
        let first = stack.popLast()!
        stack.append(first * second)
    case .minimum:
        let second = stack.popLast()!
        let first = stack.popLast()!
        stack.append(min(first, second))
    case .maximum:
        let second = stack.popLast()!
        let first = stack.popLast()!
        stack.append(max(first, second))
    case .greaterThan:
        let second = stack.popLast()!
        let first = stack.popLast()!
        stack.append(first > second ? 1 : 0)
    case .lessThan:
        let second = stack.popLast()!
        let first = stack.popLast()!
        stack.append(first < second ? 1 : 0)
    case .equalTo:
        let second = stack.popLast()!
        let first = stack.popLast()!
        stack.append(first == second ? 1 : 0)
    case .print:
        print(stack.popLast()!)
    }
}
