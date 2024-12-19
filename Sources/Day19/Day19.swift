struct Towels {
  let stripes: [String]
  let designs: [Substring]

  init(input: String) {
    let parts = input.split(separator: "\n\n")
    stripes = parts[0].split(separator: ", ").map(String.init)
    designs = parts[1].split(separator: "\n").map(Substring.init)
  }

  var possibleDesigns: Int {
    designs.count { $0.isDesignPossible(using: stripes) }
  }

  func possibleDifferentWaysToMakeDesigns() -> Int {
    var cache: [Substring: Int] = [:]
    return designs.reduce(0) {
      $0 + $1.numberOfWaysToCreateDesign(using: stripes, cache: &cache)
    }
  }
}

private extension Substring {
  func isDesignPossible(using stripes: [String]) -> Bool {
    guard !isEmpty else { return true }

    for stripe in stripes {

      if hasPrefix(stripe) {
        var design = self[...]
        design.removeFirst(stripe.count)
        if design.isDesignPossible(using: stripes) {
          return true
        }
      }
    }

    return false
  }

  func numberOfWaysToCreateDesign(using stripes: [String], cache: inout [Substring: Int]) -> Int {
    guard !isEmpty else { return 1 }

    if let cached = cache[self] { return cached }

    var possibleWays = 0

    for stripe in stripes {

      if hasPrefix(stripe) {
        var design = self[...]
        design.removeFirst(stripe.count)

        possibleWays += design.numberOfWaysToCreateDesign(using: stripes, cache: &cache)
      }
    }

    cache[self] = possibleWays

    return possibleWays
  }
}

public func part1(input: String) -> Int {
  let towels = Towels(input: input)
  return towels.possibleDesigns
}

public func part2(input: String) -> Int {
  let towels = Towels(input: input)
  return towels.possibleDifferentWaysToMakeDesigns()
}
