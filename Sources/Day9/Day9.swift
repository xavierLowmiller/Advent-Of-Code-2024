struct DiskMap {
  var disk: [Int?]

  init(_ input: String) {
    var disk: [Int?] = []
    disk.reserveCapacity(input.count * 10)
    var id = 0

    for (offset, c) in input.enumerated() {
      let count = Int(String(c))!

      if offset.isMultiple(of: 2) {
        defer { id += 1 }
        disk.append(contentsOf: Array(repeating: id, count: count))
      } else {
        disk.append(contentsOf: Array(repeating: nil, count: count))
      }
    }

    self.disk = disk
  }

  mutating func compact() {
    var p0 = disk.startIndex
    var p1 = disk.endIndex.advanced(by: -1)

    while p0 < p1 {
      p0 += 1
      guard disk[p0] == nil else { continue }

      disk[p0] = disk[p1]
      disk[p1] = nil

      while disk[p1] == nil, p1 > disk.startIndex {
        p1 -= 1
      }
    }
  }

  mutating func compactEntireFiles() {
    var p0 = disk.startIndex
    var p1 = disk.endIndex.advanced(by: -1)

    while p1 > disk.startIndex, p1 > p0 {
      defer { p1 -= 1 }
      guard disk[p1] != nil else { continue }

      var startOfFileToMove = p1
      while disk[p1] == disk[startOfFileToMove], startOfFileToMove > disk.startIndex {
        startOfFileToMove -= 1
      }
      startOfFileToMove += 1
      startOfFileToMove = min(p1, startOfFileToMove)
      defer { p1 = startOfFileToMove }

      let sizeOfFileToMove = p1 - startOfFileToMove + 1

      defer { p0 = disk.firstIndex(where: { $0 == nil })! }

      while p0 + sizeOfFileToMove < disk.endIndex {
        if disk[p0..<(p0 + sizeOfFileToMove)].allSatisfy({ $0 == nil }) {
          break
        } else {
          p0 += 1
        }
      }

      if p0 + sizeOfFileToMove < disk.endIndex, p1 > p0 {
        for i in 0..<sizeOfFileToMove {
          disk[p0 + i] = disk[startOfFileToMove + i]
          disk[startOfFileToMove + i] = nil
        }
      }
    }
  }

  var checkSum: Int {
    disk.enumerated().reduce(0) { $0 + $1.offset * ($1.element ?? 0) }
  }
}

public func part1(input: String) -> Int {
  var disk = DiskMap(input)
  disk.compact()
  return disk.checkSum
}

public func part2(input: String) -> Int {
  var disk = DiskMap(input)
  disk.compactEntireFiles()
  return disk.checkSum
}
