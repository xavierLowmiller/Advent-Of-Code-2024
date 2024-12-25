struct Lock {
  let pins: [Int]

  init?(_ input: Substring) {
    let lines = input.split(separator: "\n").map(String.init)
    guard lines.first == "#####" else { return nil }
    self.pins = parsePins(in: lines)
  }
}

struct Key {
  let pins: [Int]

  init?(_ input: Substring) {
    let lines = input.split(separator: "\n").map(String.init)
    guard lines.last == "#####" else { return nil }
    self.pins = parsePins(in: lines)
  }
}

private func parsePins(in lines: [String]) -> [Int] {
  var pins: [Int] = []

  for i in lines[0].indices {
    pins.append(lines.count(where: { $0[i] == "#" }) - 1)
  }

  assert(pins.count == 5)
  return pins
}

public func part1(input: String) -> Int {
  let parts = input.split(separator: "\n\n")

  let keys = parts.compactMap(Key.init)
  let locks = parts.compactMap(Lock.init)

  var total = 0
  for key in keys {
    for lock in locks {
      let combination = zip(key.pins, lock.pins).map { $0 + $1 }
      if combination.allSatisfy({ $0 <= 5 }) {
        total += 1
      }
    }
  }

  return total
}
