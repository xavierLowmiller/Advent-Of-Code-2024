import AOCAlgorithms
import Algorithms

public struct Point: Hashable, Sendable {
  public let x, y: Int

  var neighbors: Set<Point> {
    [
      Point(x: x, y: y - 1),
      Point(x: x, y: y + 1),
      Point(x: x - 1, y: y),
      Point(x: x + 1, y: y),
    ]
  }

  func distance(to other: Point) -> Int {
    abs(x - other.x) + abs(y - other.y)
  }

  public init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  init(_ input: Substring) {
    let values = input.split(separator: ",")
    x = Int(values[0])!
    y = Int(values[1])!
  }
}

struct Grid {
  let bounds: (x: Int, y: Int)
  let walls: Set<Point>

  init(_ input: some Sequence<Substring>, gridSize: Int) {
    bounds = (gridSize, gridSize)
    walls = Set(input.map { Point($0) })
  }

  func shortestPath(from start: Point, to goal: Point) -> [Point]? {
    aStar(
      start: start,
      goal: goal,
      heuristic: { $0.distance(to: goal) },
      neighbors: {
        $0.neighbors.filter {
          !walls.contains($0) &&
          0...bounds.x ~= $0.x &&
          0...bounds.y ~= $0.y
        }
      }
    )
  }
}

public func part1(input: String, gridSize: Int, bytes: Int) -> Int {
  let input = input.split(separator: "\n").prefix(bytes)
  let grid = Grid(input, gridSize: gridSize)
  let start = Point(x: 0, y: 0)
  let goal = Point(x: gridSize, y: gridSize)

  guard let path = grid.shortestPath(from: start, to: goal) else { return .max }

  return path.count - 1
}

public func part2(input: String, gridSize: Int) -> Point {
  let input = input.split(separator: "\n")
  var bytes = 0
  while bytes < input.count {
    let input = input.prefix(bytes)
    let grid = Grid(input, gridSize: gridSize)
    let start = Point(x: 0, y: 0)
    let goal = Point(x: gridSize, y: gridSize)
    let path = grid.shortestPath(from: start, to: goal)
    if path == nil {
      return Point(input.last!)
    }
    bytes += 1
  }

  fatalError()
}
