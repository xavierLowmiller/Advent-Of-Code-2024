extension Int {

  mutating func next() {
    self ^= self * 64
    self %= 16777216

    self ^= self / 32
    self %= 16777216

    self ^= self * 2048
    self %= 16777216
  }

  var sequence: some Sequence<Int> {
    var current = self

    return AnyIterator {
      defer { current.next() }
      return current % 10
    }
  }
}

private func sumOfGeneratedNumbers(numbers: [Int]) -> Int {
  numbers.reduce(0) {
    var number = $1
    for _ in 0..<2000 {
      number.next()
    }
    return $0 + number
  }
}

struct Key: Hashable {
  let a: Int
  let b: Int
  let c: Int
  let d: Int
}

private extension [Int] {
  var priceMap: [Key: Int] {
    var priceMap: [Key: Int] = [:]
    priceMap.reserveCapacity(2000)

    for ((((a, b), c), d), e) in zip(zip(zip(zip(self, self.dropFirst()), self.dropFirst(2)), self.dropFirst(3)), self.dropFirst(4)) {
      let key = Key(a: b - a, b: c - b, c: d - c, d: e - d)

      if priceMap[key] == nil {
        priceMap[key] = e
      }
    }

    return priceMap
  }
}

public func part1(input: String) -> Int {
  let numbers = input.split(separator: "\n").map { Int($0)! }
  return sumOfGeneratedNumbers(numbers: numbers)
}

public func part2(input: String) async -> Int {
  let numbers = input.split(separator: "\n").map { Int($0)! }

  let lookup = await withTaskGroup(of: (key: Int, value: [Key: Int]).self) { group in
    for number in numbers {
      group.addTask {
        return (number, Array(number.sequence.prefix(2000)).priceMap)
      }
    }
    return await group.reduce(into: [:]) {
      $0[$1.key] = $1.value
    }
  }

  let allPossibilities: Set<Key> = Set(lookup.values.flatMap(\.keys))

  return await withTaskGroup(of: Int.self) { group in
    for key in allPossibilities {
      group.addTask {
        numbers.reduce(into: 0) {
          if let price = lookup[$1]?[key] {
            $0 += price
          }
        }
      }
    }

    return await group.reduce(0, max)
  }
}
