public func part1(input: String) -> Int {
  let levels = parseLevels(input)
  return levels.count(where: \.isSafe)
}

public func part2(input: String) -> Int {
  let levels = parseLevels(input)
  return levels.count {
    // Sequence is directly safe
    if $0.isSafe { return true }

    // Sequence is safe when skipping one position
    for index in $0.indices {
      let skippingOneIndex = zip($0.indices, $0)
        .compactMap { $0 == index ? nil : $1 }
      if skippingOneIndex.isSafe {
        return true
      }
    }

    // Sequence isn't safe
    return false
  }
}

private func parseLevels(_ input: String) -> [[Int]] {
  let lines = input.split(separator: "\n")

  return lines.map { line in
    line.split(whereSeparator: \.isWhitespace).compactMap { Int($0) }
  }
}

private extension [Int] {

  var isSafe: Bool {
    isSorted && adjacentLevelsDifferByLessThanThree
  }

  private var isSorted: Bool {
    let pairs = zip(self, self.dropFirst())
    return pairs.allSatisfy { $0 <= $1 } || pairs.allSatisfy { $0 >= $1 }
  }

  private var adjacentLevelsDifferByLessThanThree: Bool {
    zip(self, self.dropFirst())
      .allSatisfy { 1...3 ~= abs($0 - $1) }
  }
}
