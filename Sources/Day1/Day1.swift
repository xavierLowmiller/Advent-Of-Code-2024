public func part1(input: String) -> Int {
  let (list1, list2) = parseLists(input)

  return zip(
    list1.sorted(),
    list2.sorted()
  ).reduce(0) { total, numbers in
    total + abs(numbers.0 - numbers.1)
  }
}


public func part2(input: String) -> Int {
  let (list1, list2) = parseLists(input)

  let lookup: [Int: Int] = list2.reduce(into: [:]) {
    $0[$1, default: 0] += 1
  }

  return list1.reduce(0) { partialResult, number in
    let multiplier = lookup[number, default: 0]
    return partialResult + number * multiplier
  }
}


private func parseLists(_ input: String) -> ([Int], [Int]) {
  input
    .split(separator: "\n")
    .reduce(into: ([], [])) { partialResult, line in

      let numbers = line
        .split(omittingEmptySubsequences: true, whereSeparator: \.isWhitespace)
        .compactMap { Int($0) }

      partialResult.0.append(numbers[0])
      partialResult.1.append(numbers[1])
    }
}
