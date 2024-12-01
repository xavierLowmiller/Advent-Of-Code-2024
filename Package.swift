// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "AdventOfCodeTemplate",
  platforms: [.macOS(.v13)],
  products: [
    .plugin(
      name: "CreateDays",
      targets: [
        "CreateDays"
      ]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.1.4"),
  ],
  targets: [
    .target(name: "AOCAlgorithms", dependencies: [
      .product(name: "DequeModule", package: "swift-collections"),
      .product(name: "HeapModule", package: "swift-collections"),
    ]),
    .testTarget(name: "AOCAlgorithmsTests", dependencies: ["AOCAlgorithms"]),
      .plugin(
        name: "CreateDays",
        capability: .command(
          intent: .custom(verb: "create-days", description: "Creates a bunch of folders"),
          permissions: [
            .writeToPackageDirectory(reason: "This command creates templates for each day")
          ]
        )
      )
  ]
)

for day in 1...25 {
  let day = "Day\(day)"
  package.targets.append(.target(name: day, dependencies: ["AOCAlgorithms"]))
  package.targets.append(.testTarget(name: day + "Tests", dependencies: [.target(name: day)]))
  package.products.append(.library(name: day, targets: [day]))
}
