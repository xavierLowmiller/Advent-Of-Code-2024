struct Stones {
  var stones: [Int]

  init(_ input: String) {
    stones = input.split(whereSeparator: \.isWhitespace).compactMap { Int($0) }
  }

  mutating func blink(_ times: Int) {
    for _ in 0..<times {
      var newStones: [Int] = []
      newStones.reserveCapacity(stones.count)
      for stone in stones {
        if stone == 0 {
          newStones.append(1)
        } else if let splitStones = stone.split {
          newStones.append(splitStones.0)
          newStones.append(splitStones.1)
        } else {
          newStones.append(2024 * stone)
        }
      }
      stones = newStones
    }
  }

  var count: Int {
    stones.count
  }

  func stones(afterBlinking times: Int) -> Int {
    stones.stones(afterBlinking: times)
  }
}

private struct CacheKey: Hashable {
  let stone: Int
  let times: Int
}

private extension Int {
  var split: (Int, Int)? {
    let string = String(self)
    let count = string.count
    guard count.isMultiple(of: 2) else { return nil }
    return (
      Int(string.prefix(count / 2))!,
      Int(string.suffix(count / 2))!
    )
  }

  func stones(afterBlinking times: Int, cache: inout [CacheKey: Int]) -> Int {
    guard times > 0 else { return 1 }
    if let cached = cache[CacheKey(stone: self, times: times)] { return cached }

    let newStones = self.newStones

    let result = newStones.reduce(0) {
      $0 + $1.stones(afterBlinking: times - 1, cache: &cache)
    }

    cache[CacheKey(stone: self, times: times)] = result

    return result
  }

  var newStones: [Int] {
    if self == 0 {
      [1]
    } else if let splitStones = self.split {
      [splitStones.0, splitStones.1]
    } else {
      [self * 2024]
    }
  }
}

private extension [Int] {
  func stones(afterBlinking times: Int) -> Int {

    var cache: [CacheKey: Int] = [:]

    return reduce(0) { $0 + $1.stones(afterBlinking: times, cache: &cache) }
  }
}

public func part1(input: String, blinks: Int = 25) -> Int {
  let stones = Stones(input)
  return stones.stones(afterBlinking: blinks)
}
