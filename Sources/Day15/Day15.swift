struct Point: Hashable {
  var x, y: Int

  mutating func move(in direction: Direction) {
    switch direction {
    case .up: y -= 1
    case .down: y += 1
    case .left: x -= 1
    case .right: x += 1
    }
  }

  func moving(in direction: Direction) -> Point {
    var copy = self
    copy.move(in: direction)
    return copy
  }
}

enum Direction {
  case up, down, left, right

  init?(_ character: Character) {
    switch character {
    case "^": self = .up
    case "v": self = .down
    case "<": self = .left
    case ">": self = .right
    default: return nil
    }
  }
}

struct Warehouse: Equatable, CustomDebugStringConvertible {
  let wide: Bool
  var robot: Point = Point(x: -1, y: -1)
  var walls: Set<Point> = []
  var leftHalves: Set<Point> = []
  var rightHalves: Set<Point> = []
  var directions: [Direction]

  init(_ input: String, wide: Bool) {
    let parts = input.split(separator: "\n\n")
    assert(parts.count == 2)
    for (y, line) in parts[0].split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        let factor = wide ? 2 : 1
        var point = Point(x: x * factor, y: y)

        switch c {
        case "#":
          walls.insert(point)
          if wide {
            point.move(in: .right)
            walls.insert(point)
          }
        case "@":
          robot = point
        case "O":
          leftHalves.insert(point)
          if wide {
            point.move(in: .right)
            rightHalves.insert(point)
          }
        default:
          assert(c == ".")
        }
      }
    }

    self.wide = wide
    directions = parts[1].compactMap(Direction.init)
    assert(directions.count == parts[1].count(where: { !$0.isWhitespace }))
  }

  mutating func move() {
    if wide {
      for direction in directions {
        wideMove(in: direction)
      }
    } else {
      for direction in directions {
        move(in: direction)
      }
    }
  }

  mutating func wideMove(in direction: Direction) {
    guard isWideMovePossible(of: robot, in: direction) else { return }

    robot.move(in: direction)
    moveBoxes(at: robot, in: direction)
  }

  mutating func moveBoxes(at point: Point, in direction: Direction) {
    var point = point
    if leftHalves.contains(point) {
      switch direction {
      case .up, .down:
        leftHalves.remove(point)
        rightHalves.remove(point.moving(in: .right))
        point.move(in: direction)
        moveBoxes(at: point, in: direction)
        moveBoxes(at: point.moving(in: .right), in: direction)
        leftHalves.insert(point)
        rightHalves.insert(point.moving(in: .right))

      case .left:
        leftHalves.remove(point)
        rightHalves.remove(point.moving(in: .right))
        point.move(in: direction)
        moveBoxes(at: point, in: direction)
        leftHalves.insert(point)
        rightHalves.insert(point.moving(in: .right))

      case .right:
        leftHalves.remove(point)
        rightHalves.remove(point.moving(in: .right))
        point.move(in: direction)
        moveBoxes(at: point.moving(in: .right), in: direction)
        leftHalves.insert(point)
        rightHalves.insert(point.moving(in: .right))
      }
    } else if rightHalves.contains(point) {
      switch direction {
      case .up, .down:
        leftHalves.remove(point.moving(in: .left))
        rightHalves.remove(point)
        point.move(in: direction)
        moveBoxes(at: point.moving(in: .left), in: direction)
        moveBoxes(at: point, in: direction)
        leftHalves.insert(point.moving(in: .left))
        rightHalves.insert(point)

      case .left:
        leftHalves.remove(point.moving(in: .left))
        rightHalves.remove(point)
        point.move(in: direction)
        moveBoxes(at: point.moving(in: .left), in: direction)
        leftHalves.insert(point.moving(in: .left))
        rightHalves.insert(point)

      case .right:
        leftHalves.remove(point.moving(in: .left))
        rightHalves.remove(point)
        point.move(in: direction)
        moveBoxes(at: point.moving(in: .left), in: direction)
        leftHalves.insert(point)
        rightHalves.insert(point)
      }
    }
  }

  func isWideMovePossible(of point: Point, in direction: Direction) -> Bool {
    var point = point
    point.move(in: direction)

    if walls.contains(point) {
      return false
    } else if leftHalves.contains(point) {
      switch direction {
      case .up, .down:
        let left = isWideMovePossible(of: point, in: direction)
        point.move(in: .right)
        let right = isWideMovePossible(of: point, in: direction)
        return left && right

      case .left:
        point.move(in: .left)
        return isWideMovePossible(of: point, in: direction)

      case .right:
        point.move(in: .right)
        return isWideMovePossible(of: point, in: direction)
      }
    } else if rightHalves.contains(point) {
      switch direction {
      case .up, .down:
        let right = isWideMovePossible(of: point, in: direction)
        point.move(in: .left)
        let left = isWideMovePossible(of: point, in: direction)
        return left && right

      case .left:
        point.move(in: .left)
        return isWideMovePossible(of: point, in: direction)

      case .right:
        point.move(in: .right)
        return isWideMovePossible(of: point, in: direction)
      }
    } else {
      return true
    }
  }

  func isMovePossible(of point: Point, in direction: Direction) -> Bool {
    var point = point
    point.move(in: direction)

    if walls.contains(point) {
      return false
    } else if leftHalves.contains(point) {
      return isMovePossible(of: point, in: direction)
    } else {
      return true
    }
  }

  mutating func move(in direction: Direction) {
    guard isMovePossible(of: robot, in: direction) else { return }

    robot.move(in: direction)
    var newPoint = robot

    var isAtBox = leftHalves.contains(newPoint)
    while isAtBox {
      newPoint.move(in: direction)
      isAtBox = leftHalves.contains(newPoint)
    }
    leftHalves.insert(newPoint)
    leftHalves.remove(robot)
  }

  var checkSum: Int {
    leftHalves.reduce(0) { $0 + $1.x + $1.y * 100 }
  }

  var debugDescription: String {
    let maxX = walls.map(\.x).max()!
    let maxY = walls.map(\.y).max()!

    var s = ""
    s.reserveCapacity(maxX * maxY)
    for y in 0...maxY {
      for x in 0...maxX {
        let point = Point(x: x, y: y)
        if point == robot {
          s.append("@")
        } else if walls.contains(point) {
          s.append("#")
        } else if leftHalves.contains(point) {
          if wide {
            s.append("[")
          } else {
            s.append("O")
          }
        } else if rightHalves.contains(point) {
          s.append("]")
        } else {
          s.append(".")
        }
      }
      s += "\n"
    }
    s.removeLast()
    return s
  }
}

public func part1(input: String) -> Int {
  var warehouse = Warehouse(input, wide: false)
  warehouse.move()
  return warehouse.checkSum
}

public func part2(input: String) -> Int {
  var warehouse = Warehouse(input, wide: true)
  warehouse.move()
  return warehouse.checkSum
}
