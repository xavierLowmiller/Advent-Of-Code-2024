import Foundation
import PackagePlugin

@main
struct CreateDays: CommandPlugin {
  func performCommand(
    context: PluginContext,
    arguments: [String]
  ) throws {
    for day in 1...25 {
      try createFilesIfNeeded(for: "Day\(day)")
    }
  }
}

func createFilesIfNeeded(for day: String) throws {
  let filesToCreate = [
    "./Sources/\(day)/\(day).swift",
    "./Tests/\(day)Tests/\(day)Tests.swift",
    "./Tests/\(day)Tests/Input.swift",
  ]

  for file in filesToCreate {
    if !FileManager.default.fileExists(atPath: file) {
      try FileManager.default.createDirectory(atPath: file.deletingLastPathComponent, withIntermediateDirectories: true)
      FileManager.default.createFile(atPath: file, contents: nil)
    }
  }
}

private extension String {
  var deletingLastPathComponent: String {
    self.split(separator: "/").dropLast(1).joined(separator: "/")
  }
}
