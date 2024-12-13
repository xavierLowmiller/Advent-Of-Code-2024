struct Point: Hashable {
  let x, y: Int
}

struct Game {
  let a: Point
  let b: Point
  let prize: Point

  init?(_ input: Substring, corrected: Bool) {
    let lines = input.split(separator: "\n")

    guard let a = lines[0].firstMatch(of: /Button A: X\+(\d+), Y\+(\d+)/),
          let b = lines[1].firstMatch(of: /Button B: X\+(\d+), Y\+(\d+)/),
          let prize = lines[2].firstMatch(of: /Prize: X=(\d+), Y=(\d+)/)
    else { return nil }

    self.a = Point(x: Int(a.output.1)!, y: Int(a.output.2)!)
    self.b = Point(x: Int(b.output.1)!, y: Int(b.output.2)!)
    if corrected {
      self.prize = Point(
        x: Int(prize.output.1)! + 10000000000000,
        y: Int(prize.output.2)! + 10000000000000
      )
    } else {
      self.prize = Point(x: Int(prize.output.1)!, y: Int(prize.output.2)!)
    }
  }

  var minimumCost: Int? {

    let determinant = det(a, b)
    let determinantA = det(prize, b)
    let determinantB = det(a, prize)

    guard determinant != 0,
          determinantA % determinant == 0,
          determinantB % determinant == 0
    else { return nil }

    let aPresses = determinantA / determinant
    let bPresses = determinantB / determinant

    assert(aPresses * a.x + bPresses * b.x == prize.x)
    assert(aPresses * a.y + bPresses * b.y == prize.y)

    return aPresses * 3 + bPresses * 1
  }
}

func det(_ p1: Point, _ p2: Point) -> Int {
  p1.x * p2.y - p1.y * p2.x
}

public func part1(input: String) -> Int {
  let games = input.split(separator: "\n\n").compactMap { Game($0, corrected: false) }
  return games.reduce(0) { $0 + ($1.minimumCost ?? 0) }
}

public func part2(input: String) -> Int {
  let games = input.split(separator: "\n\n").compactMap { Game($0, corrected: true) }
  return games.reduce(0) { $0 + ($1.minimumCost ?? 0) }
}
