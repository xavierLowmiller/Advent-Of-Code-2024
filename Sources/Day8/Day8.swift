import Algorithms

struct Point: Hashable {
  let x, y: Int

  var inverted: Point {
    Point(x: -x, y: -y)
  }

  func subtracting(_ other: Point) -> Point {
    Point(x: x - other.x, y: y - other.y)
  }

  func adding(_ other: Point) -> Point {
    Point(x: x + other.x, y: y + other.y)
  }
}

struct Map {
  let antennas: [Character: Set<Point>]
  let extent: (x: Int, y: Int)

  init(_ input: String) {
    var extent: (x: Int, y: Int) = (0, 0)
    var antennas: [Character: Set<Point>] = [:]
    for (y, line) in input.split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        if c != "." {
          let position = Point(x: x, y: y)
          antennas[c, default: []].insert(position)
        }
        extent.x = max(extent.x, x)
      }
      extent.y = max(extent.y, y)
    }
    self.antennas = antennas
    self.extent = extent
  }

  func antiNodes(recurrent: Bool) -> Set<Point> {
    var nodes: Set<Point> = []
    for character in antennas.keys {
      nodes.formUnion(antiNodes(of: character, recurrent: recurrent))
    }
    return nodes
  }

  private func antiNodes(of character: Character, recurrent: Bool) -> Set<Point> {
    let positions = antennas[character]!
    var nodes: Set<Point> = []

    for (p1, p2) in product(positions, positions) {
      guard p1 != p2 else { continue }

      let diff = p2.subtracting(p1)

      if recurrent {
        var next1 = p1
        while (0...extent.x) ~= next1.x, (0...extent.y) ~= next1.y {
          nodes.insert(next1)
          next1 = next1.adding(diff.inverted)
        }
        var next2 = p2
        while (0...extent.x) ~= next2.x, (0...extent.y) ~= next2.y {
          nodes.insert(next2)
          next2 = next2.adding(diff.inverted)
        }
      } else {
        let r1 = p1.adding(diff.inverted)
        if (0...extent.x) ~= r1.x, (0...extent.y) ~= r1.y {
          nodes.insert(r1)
        }
        let r2 = p2.adding(diff)
        if (0...extent.x) ~= r2.x, (0...extent.y) ~= r2.y {
          nodes.insert(r2)
        }
      }
    }

    return nodes
  }
}

public func part1(input: String) -> Int {
  return Map(input).antiNodes(recurrent: false).count
}

public func part2(input: String) -> Int {
  return Map(input).antiNodes(recurrent: true).count
}

