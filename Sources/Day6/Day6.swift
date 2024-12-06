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
    guard 0...bounds.x ~= next.x, 0...bounds.y ~= next.y else { return false }
    
    if obstructions.contains(next) {
      direction.turn()
    } else {
      position = next
    }
    return true
  }
}

struct Board {
  var _guard: Guard
  var bounds: (x: Int, y: Int) = (0, 0)
  var obstructions: Set<Point> = []
  var routeTaken: Set<Point>

  init(_ input: String) {
    var _guard: Guard!
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
    self.routeTaken = [_guard.position]
  }

  mutating func moveGuard() {
    while _guard.move(obstructions, bounds: bounds) {
      routeTaken.insert(_guard.position)
    }
  }

  mutating func moveGuardAndCheckForLoops() -> Bool {
    var history: Set<Guard> = [_guard]
    while _guard.move(obstructions, bounds: bounds) {
      if history.contains(_guard) {
        return true
      }
      history.insert(_guard)
    }
    return false
  }
}

public func part1(input: String) -> Int {
  var board = Board(input)
  board.moveGuard()
  return board.routeTaken.count
}

public func part2(input: String) -> Int {
  let board = Board(input)
  var total = 0
  for y in 0...board.bounds.y {
    for x in 0...board.bounds.x {
      let newObstruction = Point(x: x, y: y)
      guard !board.obstructions.contains(newObstruction) else { continue }
      guard board._guard.position != newObstruction else { continue }

      var board = board
      board.obstructions.insert(newObstruction)
      if board.moveGuardAndCheckForLoops() {
        total += 1
      }
    }
  }
  return total
}
