struct Point: Hashable, CustomDebugStringConvertible {
  var x, y: Int

  var neighbors: [Point] {
    [
      Point(x: x, y: y + 1),
      Point(x: x, y: y - 1),
      Point(x: x + 1, y: y),
      Point(x: x - 1, y: y),
    ]
  }

  func isNeighbor(of point: Point) -> Bool {
    (abs(x - point.x) == 1 && y == point.y) ||
    (abs(y - point.y) == 1 && x == point.x)
  }

  var debugDescription: String {
    "Point: (\(x), \(y))"
  }
}

typealias Region = Set<Point>

struct GardenPlot {
  let map: [Point: Character]

  init(_ input: String) {
    var map: [Point: Character] = [:]
    for (y, line) in input.split(separator: "\n").enumerated() {
      for (x, c) in line.enumerated() {
        let point = Point(x: x, y: y)
        map[point] = c
      }
    }
    self.map = map
  }

  private var regions: [Region] {
    var result: [Region] = []
    var seen: Set<Point> = []

    for point in map.keys {
      guard !seen.contains(point) else { continue }

      var remaining = [point]
      var region: Region = [point]

      while !remaining.isEmpty {
        let point = remaining.removeLast()
        region.insert(point)
        seen.insert(point)

        let neighbors = point.neighbors

        for neighbor in neighbors {
          guard map[neighbor] == map[point], !seen.contains(neighbor)
          else { continue }

          remaining.append(neighbor)
        }
      }

      result.append(region)
    }

    return result
  }

  var totalFencingPrice: Int {
    regions.reduce(0) { $0 + $1.price }
  }

  var totalFencingPriceIncludingDiscount: Int {
    regions.reduce(0) { $0 + $1.discountedPrice }
  }
}

private extension Region {
  var price: Int {
    return count * perimeter
  }

  var discountedPrice: Int {
    return count * sides
  }

  private var perimeter: Int {
    var perimeter = 0
    for point in self {
      perimeter += point
        .neighbors
        .filter { !self.contains($0) }
        .count
    }
    return perimeter
  }

  private var sides: Int {
    var sides = 0

    let xExtent = map(\.x).min()! ... map(\.x).max()!
    let yExtent = map(\.y).min()! ... map(\.y).max()!

    // From the top
    sides += edges(
      initial: xExtent.map { Point(x: $0, y: yExtent.lowerBound - 1) },
      step: { points in
        guard points[0].y < yExtent.upperBound else { return nil }
        return points.map { var copy = $0; copy.y += 1; return copy } }
    )

    // From the bottom
    sides += edges(
      initial: xExtent.map { Point(x: $0, y: yExtent.upperBound + 1) },
      step: { points in
        guard points[0].y > yExtent.lowerBound else { return nil }
        return points.map { var copy = $0; copy.y -= 1; return copy } }
    )

    // From the left
    sides += edges(
      initial: yExtent.map { Point(x: xExtent.lowerBound - 1, y: $0) },
      step: { points in
        guard points[0].x < xExtent.upperBound else { return nil }
        return points.map { var copy = $0; copy.x += 1; return copy } }
    )

    // From the right
    sides += edges(
      initial: yExtent.map { Point(x: xExtent.upperBound + 1, y: $0) },
      step: { points in
        guard points[0].x > xExtent.lowerBound else { return nil }
        return points.map { var copy = $0; copy.x -= 1; return copy } }
    )

    return sides
  }

  private func edges(initial: [Point], step: ([Point]) -> [Point]?) -> Int {
    var points = initial
    var sides = 0
    while let next = step(points) {
      defer {
        points = next
      }
      let edgePoints = zip(points, next)
        .filter { contains($1) && !contains($0) }
        .map(\.0)

      sides += edgePoints.sides
    }
    return sides
  }
}

private extension [Point] {
  var sides: Int {
    var sides = 0
    var points = self
    while !points.isEmpty {
      sides += 1

      // Remove neighboring points because they count as a single edge
      var last = points.removeLast()
      while let nextLast = points.last {
        defer { last = nextLast }
        if last.isNeighbor(of: nextLast) {
          points.removeLast()
        } else {
          break
        }
      }
    }

    return sides
  }
}

public func part1(input: String) -> Int {
  let plot = GardenPlot(input)
  return plot.totalFencingPrice
}

public func part2(input: String) -> Int {
  let plot = GardenPlot(input)
  return plot.totalFencingPriceIncludingDiscount
}
