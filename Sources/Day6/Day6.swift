struct Point: Hashable {
  let x, y: Int

  func next(in direction: Direction) -> Point {
    switch direction {
    case .north: Point(x: x, y: y - 1)
    case .south: Point(x: x, y: y + 1)
    case .east: Point(x: x + 1, y: y)
    case .west: Point(x: x - 1, y: y)
    }
  }
}

enum Direction {
  case north, south, east, west

  mutating func turn() {
    switch self {
    case .north: self = .east
    case .south: self = .west
    case .east: self = .south
    case .west: self = .north
    }
  }
}

struct Guard: Hashable {
  var position: Point
  var direction: Direction = .north

  mutating func move(_ obstructions: Set<Point>, bounds: (x: Int, y: Int)) -> Bool {
    let next = position.next(in: direction)
    guard 0...bounds.x ~= next.x, 0...bounds.y ~= next.y else {
      // Guard has left the board -> We're done
      return false
    }

    if obstructions.contains(next) {
      direction.turn()
    } else {
      position = next
    }
    return true
  }
}

struct Board {
  let _guard: Guard
  let bounds: (x: Int, y: Int)
  var obstructions: Set<Point>

  init(_ input: String) {
    var _guard: Guard!
    var bounds: (x: Int, y: Int) = (0, 0)
    var obstructions = Set<Point>(minimumCapacity: input.count)

    for (y, line) in input.split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        let point = Point(x: x, y: y)
        switch c {
        case "#": obstructions.insert(point)
        case "^": _guard = Guard(position: point)
        case _: break
        }
        bounds.x = max(bounds.x, x)
      }
      bounds.y = max(bounds.x, y)
    }

    self._guard = _guard
    self.bounds = bounds
    self.obstructions = obstructions
  }

  func moveGuardToEdge() -> Set<Point> {
    var _guard = _guard
    var routeTaken = Set<Point>(minimumCapacity: bounds.x * bounds.y)
    routeTaken.insert(_guard.position)

    while _guard.move(obstructions, bounds: bounds) {
      routeTaken.insert(_guard.position)
    }
    return routeTaken
  }

  func moveGuardAndCheckForLoops() -> Bool {
    var _guard = _guard
    var history = Set<Guard>(minimumCapacity: bounds.x * bounds.y)
    history.insert(_guard)

    while _guard.move(obstructions, bounds: bounds) {
      guard !history.contains(_guard) else { return true }
      history.insert(_guard)
    }

    return false
  }

  func numberOfPossibleObstructions() async -> Int {
    let routeTaken = moveGuardToEdge()

    return await withTaskGroup(of: Bool.self, returning: Int.self) { group in
      for newObstruction in routeTaken {
        guard !obstructions.contains(newObstruction) else { continue }
        guard _guard.position != newObstruction else { continue }

        group.addTask {
          var board = self
          board.obstructions.insert(newObstruction)
          return board.moveGuardAndCheckForLoops()
        }
      }

      return await group.reduce(0) { $0 + ($1 ? 1 : 0) }
    }
  }
}

public func part1(input: String) -> Int {
  let board = Board(input)
  return board.moveGuardToEdge().count
}

public func part2(input: String) async -> Int {
  let board = Board(input)
  return await board.numberOfPossibleObstructions()
}
