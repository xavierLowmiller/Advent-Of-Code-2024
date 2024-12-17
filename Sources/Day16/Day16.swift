import AOCAlgorithms

struct Point: Hashable {
  var x, y: Int

  func moved(in direction: Direction) -> Point {
    switch direction {
    case .north: Point(x: x, y: y - 1)
    case .south: Point(x: x, y: y + 1)
    case .west: Point(x: x - 1, y: y)
    case .east: Point(x: x + 1, y: y)
    }
  }

  var neighbors: [Point] {
    [
      Point(x: x, y: y - 1),
      Point(x: x, y: y + 1),
      Point(x: x - 1, y: y),
      Point(x: x + 1, y: y),
    ]
  }

  func possibleDirections(_ walls: Set<Point>, currentDirection: Direction) -> [Direction] {
    var directions: [Direction] = []
    for direction in currentDirection.neighbors + [currentDirection] {
      let point = self.moved(in: direction)
      if !walls.contains(point) {
        directions.append(direction)
      }
    }
    return directions
  }

  func distance(to other: Point) -> Int {
    abs(x - other.x) + abs(y - other.y)
  }
}

enum Direction: Hashable {
  case north, south, west, east

  var neighbors: [Direction] {
    switch self {
    case .north, .south: [.west, .east]
    case .west, .east: [.north, .south]
    }
  }

  func distance(to other: Direction) -> Int {
    switch (self, other) {
    case (.north, .north), (.south, .south), (.east, .east), (.west, .west):
      0
    case (.north, .east), (.north, .west),
      (.south, .east), (.south, .west),
      (.east, .north), (.east, .south),
      (.west, .north), (.west, .south):
      1
    case (.north, .south), (.south, .north), (.east, .west), (.west, .east):
      2
    }
  }
}

struct Reindeer: Hashable {
  var position: Point
  var direction: Direction = .east

  func possibleMoves(in walls: Set<Point>) -> [(Reindeer, cost: Int)] {
    var possibleMoves: [(Reindeer, cost: Int)] = []
    for direction in direction.neighbors {
      if !walls.contains(position.moved(in: direction)) {
        possibleMoves.append((Reindeer(position: position, direction: direction), 1000))
      }
    }
    if !walls.contains(position.moved(in: direction)) {
      possibleMoves.append((Reindeer(position: position.moved(in: direction), direction: direction), 1))
    }

    assert(!possibleMoves.contains(where: { $0.0 == self }))

    return possibleMoves
  }

  func cost(other: Reindeer) -> Int {
    if position == other.position {
      assert(direction.distance(to: other.direction) == 1)
      return 1000
    } else if direction == other.direction {
      assert(position.distance(to: other.position) == 1)
      return 1
    } else {
      fatalError()
    }
  }
}

struct Maze {
  let reindeer: Reindeer
  let walls: Set<Point>
  let goal: Point

  init(_ input: String) {
    var reindeer: Reindeer!
    var walls: Set<Point> = []
    var goal: Point!

    for (y, line) in input.split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        let point = Point(x: x, y: y)
        switch c {
        case "#": walls.insert(point)
        case "E": goal = point
        case "S": reindeer = Reindeer(position: point)
        case _: assert(c == ".")
        }
      }
    }

    self.reindeer = reindeer
    self.walls = walls
    self.goal = goal
  }

  var lowestScoreToGoal: Int {
    let path = aStar(
      start: reindeer,
      goal: { $0.position == goal },
      cost: { $0.cost(other: $1) },
      heuristic: { $0.position.distance(to: goal) },
      neighbors: { $0.possibleMoves(in: walls).map(\.0) }
    )!

    return path.cost
  }

  var countOfPointsOnOptimalPath: Int {

    let allMinimalPathTiles = pluralAStar(
      start: reindeer,
      goal: { $0.position == goal },
      cost: { $0.cost(other: $1) },
      heuristic: { $0.position.distance(to: goal) },
      neighbors: { $0.possibleMoves(in: walls).map(\.0) }
    )

    return Set(allMinimalPathTiles.map(\.position)).count

//    let maxCost = lowestScoreToGoal
//
//    let scores = paths(from: reindeer, maxCost: maxCost)
//
//    return scores
//      .min(by: { $0.key < $1.key })?
//      .value
//      .reduce(into: Set<Point>()) { $0.formUnion($1) }
//      .count ?? 0
  }

  private func paths(
    from reindeer: Reindeer,
    seen: Set<Point> = [],
    cost: Int = 0,
    maxCost: Int
  ) -> [Int: [Set<Point>]] {
    guard cost <= maxCost else { return [:] }

    guard reindeer.position != goal else {
      return [cost: [seen.union([reindeer.position])]]
    }

    let moves =  reindeer.possibleMoves(in: walls)
      .filter { !seen.contains($0.0.position) }

    return moves.reduce(into: [:]) {
      let paths = paths(
        from: $1.0,
        seen: seen.union([reindeer.position]),
        cost: cost + $1.cost,
        maxCost: maxCost
      )

      $0.merge(paths) { $0 + $1 }
    }
  }
}

private extension Sequence where Element == Reindeer {
  var cost: Int {
    return zip(self, self.dropFirst()).reduce(0) { $0 + $1.0.cost(other: $1.1) }
  }
}

public func part1(input: String) -> Int {
  let maze = Maze(input)
  return maze.lowestScoreToGoal
}

public func part2(input: String) -> Int {
  let maze = Maze(input)
  return maze.countOfPointsOnOptimalPath
}
