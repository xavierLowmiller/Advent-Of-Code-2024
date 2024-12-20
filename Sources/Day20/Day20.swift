import AOCAlgorithms

struct Point: Hashable {
  let x, y: Int

  func distance(to other: Point) -> Int {
    abs(x - other.x) + abs(y - other.y)
  }

  var neighbors: [Point] {
    [
      Point(x: x, y: y - 1),
      Point(x: x, y: y + 1),
      Point(x: x - 1, y: y),
      Point(x: x + 1, y: y),
    ]
  }
}

struct RaceTrack {
  let walls: Set<Point>
  let start: Point
  let goal: Point

  init(_ input: String) {
    var walls: Set<Point> = []
    var start: Point!
    var goal: Point!

    for (y, line) in input.split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        let point = Point(x: x, y: y)
        switch c {
        case "#":
          walls.insert(point)
        case "S":
          start = point
        case "E":
          goal = point
        case _:
          assert(c == ".")
        }
      }
    }

    self.walls = walls
    self.start = start
    self.goal = goal
  }

  private var regularPath: [Point] {
    aStar(
      start: start,
      goal: goal,
      heuristic: { $0.distance(to: goal) },
      neighbors: { $0.neighbors.filter { !walls.contains($0) } }
    )!
  }

  func cheats(maxLength: Int) -> [Int: Int] {
    let track = regularPath

    var cheats: [Int: Int] = [:]

    for (index1, point) in track.enumerated() {
      for (index2, cheatPoint) in track.enumerated() {
        guard index2 > index1 else { continue }
        let distance = cheatPoint.distance(to: point)
        guard distance <= maxLength else { continue }
        let cheatDistance = index2 - index1 - distance
        guard cheatDistance > 0 else { continue }
        cheats[cheatDistance, default: 0] += 1
      }
    }

    return cheats
  }
}

public func part1(input: String) -> [Int: Int] {
  let track = RaceTrack(input)
  return track.cheats(maxLength: 2)
}

public func part2(input: String) -> [Int: Int] {
  let track = RaceTrack(input)
  return track.cheats(maxLength: 20)
}
