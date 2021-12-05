// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AoC",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "Day1",
            dependencies: [],
            resources: [.copy("Resources/day1.txt")]),
        .executableTarget(
            name: "Day2",
            dependencies: [],
            resources: [.copy("Resources/day2.txt")]),
        .executableTarget(
            name: "Day3",
            dependencies: [],
            resources: [.copy("Resources/day3.txt")]),
        .executableTarget(
            name: "Day4",
            dependencies: [],
            resources: [.copy("Resources/day4.txt")]),
        .executableTarget(
            name: "Day5",
            dependencies: [],
            resources: [.copy("Resources/day5.txt")]),
        .executableTarget(
            name: "Day6",
            dependencies: [],
            resources: [.copy("Resources/day6.txt")]),
        .executableTarget(
            name: "Day7",
            dependencies: [],
            resources: [.copy("Resources/day7.txt")]),
        .executableTarget(
            name: "Day8",
            dependencies: [],
            resources: [.copy("Resources/day8.txt")]),
        .executableTarget(
            name: "Day9",
            dependencies: [],
            resources: [.copy("Resources/day9.txt")]),
        .executableTarget(
            name: "Day10",
            dependencies: [],
            resources: [.copy("Resources/day10.txt")]),
        .executableTarget(
            name: "Day11",
            dependencies: [],
            resources: [.copy("Resources/day11.txt")]),
        .executableTarget(
            name: "Day12",
            dependencies: [],
            resources: [.copy("Resources/day12.txt")]),
        .executableTarget(
            name: "Day13",
            dependencies: [],
            resources: [.copy("Resources/day13.txt")]),
        .executableTarget(
            name: "Day14",
            dependencies: [],
            resources: [.copy("Resources/day14.txt")]),
        .executableTarget(
            name: "Day15",
            dependencies: [],
            resources: [.copy("Resources/day15.txt")]),
        .executableTarget(
            name: "Day16",
            dependencies: [],
            resources: [.copy("Resources/day16.txt")]),
        .executableTarget(
            name: "Day17",
            dependencies: [],
            resources: [.copy("Resources/day17.txt")]),
        .executableTarget(
            name: "Day18",
            dependencies: [],
            resources: [.copy("Resources/day18.txt")]),
        .executableTarget(
            name: "Day19",
            dependencies: [],
            resources: [.copy("Resources/day19.txt")]),
        .executableTarget(
            name: "Day20",
            dependencies: [],
            resources: [.copy("Resources/day20.txt")]),
        .executableTarget(
            name: "Day21",
            dependencies: [],
            resources: [.copy("Resources/day21.txt")]),
        .executableTarget(
            name: "Day22",
            dependencies: [],
            resources: [.copy("Resources/day22.txt")]),
        .executableTarget(
            name: "Day23",
            dependencies: [],
            resources: [.copy("Resources/day23.txt")]),
        .executableTarget(
            name: "Day24",
            dependencies: [],
            resources: [.copy("Resources/day24.txt")]),
        .executableTarget(
            name: "Day25",
            dependencies: [],
            resources: [.copy("Resources/day25.txt")])
    ]
)
