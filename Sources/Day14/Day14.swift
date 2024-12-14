import AOCAlgorithms

struct Vector: Hashable {
  var x, y: Int

  func distance(to other: Vector) -> Int {
    max(x, other.x) - min(x, other.x) + max(y, other.y) - min(y, other.y)
  }

  mutating func add(_ other: Vector, bounds: Size, times: Int = 1) {
    x += other.x * times
    x = x %% bounds.x
    y += other.y * times
    y = y %% bounds.y
  }
}

public typealias Size = (x: Int, y: Int)

struct Robot: Hashable {
  var position: Vector
  let velocity: Vector
}

extension Robot {
  init(_ input: Substring) {
    let match = input.firstMatch(of: /p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)!
    position = Vector(x: Int(match.output.1)!, y: Int(match.output.2)!)
    velocity = Vector(x: Int(match.output.3)!, y: Int(match.output.4)!)
  }

  mutating func move(steps: Int, in size: Size) {
    position.add(velocity, bounds: size, times: steps)
  }
}

struct Robots {
  var robots: [Robot]
  let size: Size

  init(_ input: String, size: Size) {
    self.robots = input.split(separator: "\n").map(Robot.init)
    self.size = size
  }

  func safetyFactor(after rounds: Int) -> Int {
    var robots = robots
    for _ in 0..<rounds {
      robots.move(in: size)
    }
    return robots.safetyFactor(bounds: size)
  }

  func secondsUntilChristmasImage() -> Int {
    let repCount = size.x * size.y
    var min = (Int.max, 0)

    for steps in 0..<repCount {
      var robots = robots
      robots.move(steps: steps, in: size)
      let totalDistance = robots.totalDistance

      if totalDistance < min.0 {
        min.0 = totalDistance
        min.1 = steps
      }
    }

    return min.1
  }
}

private extension [Robot] {
  mutating func move(steps: Int = 1, in size: Size) {
    for index in indices {
      self[index].move(steps: steps, in: size)
    }
  }

  func safetyFactor(bounds: Size) -> Int {
    var (a, b, c, d) = (0, 0, 0, 0)

    for robot in self {
      if robot.position.x < bounds.x / 2 && robot.position.y < bounds.y / 2 { a += 1 }
      if robot.position.x < bounds.x / 2 && robot.position.y > bounds.y / 2 { b += 1 }
      if robot.position.x > bounds.x / 2 && robot.position.y < bounds.y / 2 { c += 1 }
      if robot.position.x > bounds.x / 2 && robot.position.y > bounds.y / 2 { d += 1 }
    }

    return a * b * c * d
  }

  var totalDistance: Int {
    var distance = 0
    for r1 in self {
      for r2 in self {
        distance += r1.position.distance(to: r2.position)
      }
    }
    return distance
  }
}

public func part1(input: String, size: Size) -> Int {
  let robots = Robots(input, size: size)
  return robots.safetyFactor(after: 100)
}

public func part2(input: String, size: Size) -> Int {
  let robots = Robots(input, size: size)
  return robots.secondsUntilChristmasImage()
}
