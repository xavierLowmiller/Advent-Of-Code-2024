struct Point: Hashable {
  let x, y: Int

  var neighbors: [Point] {
    [
      Point(x: x, y: y + 1),
      Point(x: x, y: y - 1),
      Point(x: x + 1, y: y),
      Point(x: x - 1, y: y),
    ]
  }
}

struct TopographicMap {
  var map: [Point: Int] = [:]
  var trailheads: Set<Point> = []
  var peaks: Set<Point> = []

  init(_ input: String) {
    for (y, line) in input.split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        let point = Point(x: x, y: y)
        let height = Int(String(c))
        map[point] = height

        if height == 0 {
          trailheads.insert(point)
        }

        if height == 9 {
          peaks.insert(point)
        }
      }
    }
  }

  var totalHikingRoutes: Int {
    var totalHikes = 0

    for trailhead in trailheads {
      for peak in peaks {
        if pathExists(from: trailhead, to: peak) {
          totalHikes += 1
        }
      }
    }

    return totalHikes
  }

  var totalHikingRouteRatings: Int {
    trailheads.reduce(0) { $0 + totalRatings(for: $1) }
  }

  private func pathExists(from: Point, to target: Point) -> Bool {
    guard let elevation = map[from] else { return false }
    guard from != target else { return true }

    return from.neighbors.contains { neighbor in
      guard let neighborElevation = map[neighbor],
            neighborElevation == elevation + 1
      else { return false }

      return pathExists(from: neighbor, to: target)
    }
  }

  private func totalRatings(for point: Point) -> Int {
    guard let elevation = map[point] else { return 0 }
    guard elevation != 9 else { return 1 }

    return point.neighbors.reduce(into: 0) { total, neighbor in
      if let neighborElevation = map[neighbor],
         neighborElevation == elevation + 1 {
        total += totalRatings(for: neighbor)
      }
    }
  }
}

public func part1(input: String) -> Int {
  let map = TopographicMap(input)
  return map.totalHikingRoutes
}

public func part2(input: String) -> Int {
  let map = TopographicMap(input)
  return map.totalHikingRouteRatings
}
