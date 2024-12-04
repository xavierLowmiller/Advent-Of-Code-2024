struct Point: Hashable {
  let x, y: Int

  func neighbors(_ length: Int) -> [[Point]] {
    [
      // to right
      (0..<length).map { Point(x: x + $0, y: y) },
      // to left
      (0..<length).map { Point(x: x - $0, y: y) },
      // to top
      (0..<length).map { Point(x: x, y: y - $0) },
      // to bottom
      (0..<length).map { Point(x: x, y: y + $0) },
      // to top left
      (0..<length).map { Point(x: x - $0, y: y - $0) },
      // to top right
      (0..<length).map { Point(x: x + $0, y: y - $0) },
      // to bottom right
      (0..<length).map { Point(x: x + $0, y: y + $0) },
      // to bottom left
      (0..<length).map { Point(x: x - $0, y: y + $0) },
    ]
  }

  func diagonalNeighbors(_ length: Int) -> [([Point], [Point])] {
    [
      ((0..<length).map { Point(x: x - $0, y: y - $0) }, (0..<length).map { Point(x: x - $0, y: y - (length - 1) + $0) }),
      ((0..<length).map { Point(x: x - $0, y: y - $0) }, (0..<length).map { Point(x: x - (length - 1) + $0, y: y - $0) }),

      ((0..<length).map { Point(x: x - $0, y: y + $0) }, (0..<length).map { Point(x: x - (length - 1) + $0, y: y + $0) }),
      ((0..<length).map { Point(x: x - $0, y: y + $0) }, (0..<length).map { Point(x: x - $0, y: y + (length - 1) - $0) }),

      ((0..<length).map { Point(x: x + $0, y: y - $0) }, (0..<length).map { Point(x: x + $0, y: y - (length - 1) + $0) }),
      ((0..<length).map { Point(x: x + $0, y: y - $0) }, (0..<length).map { Point(x: x + (length - 1) - $0, y: y - $0) }),

      ((0..<length).map { Point(x: x + $0, y: y + $0) }, (0..<length).map { Point(x: x + (length - 1) - $0, y: y + $0) }),
      ((0..<length).map { Point(x: x + $0, y: y + $0) }, (0..<length).map { Point(x: x + $0, y: y + (length - 1) - $0) }),
    ]
  }
}

struct Words {
  let map: [Point: Character]
  let extent: (x: Int, y: Int)

  init(_ input: String) {
    var map: [Point: Character] = [:]
    var extent: (x: Int, y: Int) = (0, 0)
    for (y, line) in input.split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        map[Point(x: x, y: y)] = c
        extent.x = max(extent.x, x)
      }
      extent.y = max(extent.y, y)
    }
    self.map = map
    self.extent = extent
  }

  func count(of word: String) -> Int {
    var total = 0
    for y in 0...extent.y {
      for x in 0...extent.x {
        let point = Point(x: x, y: y)
        total += count(of: word, at: point)
      }
    }
    return total
  }

  private func count(of word: String, at point: Point) -> Int {
    var total = 0
    for n in point.neighbors(word.count) {
      if n.compactMap({ map[$0] }) == Array(word) {
        total += 1
      }
    }
    return total
  }

  func xcount(of word: String) -> Int {
    var total = 0
    for y in 0...extent.y {
      for x in 0...extent.x {
        let point = Point(x: x, y: y)
        total += xcount(of: word, at: point)
      }
    }
    return total / 2
  }

  private func xcount(of word: String, at point: Point) -> Int {
    var total = 0
    for (a, b) in point.diagonalNeighbors(word.count) {
      if a.compactMap({ map[$0] }) == Array(word),
         b.compactMap({ map[$0] }) == Array(word) {
        total += 1
      }
    }
    return total
  }
}

public func part1(input: String) -> Int {
  let words = Words(input)
  return words.count(of: "XMAS")
}

public func part2(input: String) -> Int {
  let words = Words(input)
  return words.xcount(of: "MAS")
}
