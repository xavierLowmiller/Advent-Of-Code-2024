import AOCAlgorithms

/*
 +---+---+---+
 | 7 | 8 | 9 |
 +---+---+---+
 | 4 | 5 | 6 |
 +---+---+---+
 | 1 | 2 | 3 |
 +---+---+---+
     | 0 | A |
     +---+---+
 */
func NumericPad() -> KeyPad {
  KeyPad { character in
    switch character {
    case "A": ["0", "3"]
    case "1": ["2", "4"]
    case "2": ["0", "1", "3", "5"]
    case "3": ["A", "2", "6"]
    case "4": ["1", "5", "7"]
    case "5": ["2", "4", "6", "8"]
    case "6": ["3", "5", "9"]
    case "7": ["4", "8"]
    case "8": ["5", "7", "9"]
    case "9": ["6", "8"]
    case "0": ["A", "2"]
    default: []
    }
  } move: { a, b in
    switch (a, b) {
    case ("0", "2"), ("A", "3"), ("1", "4"), ("2", "5"), ("3", "6"), ("4", "7"), ("5", "8"), ("6", "9"): "^"
    case ("7", "4"), ("8", "5"), ("9", "6"), ("4", "1"), ("5", "2"), ("6", "3"), ("3", "A"), ("2", "0"): "v"
    case ("2", "1"), ("5", "4"), ("8", "7"), ("A", "0"), ("9", "8"), ("6", "5"), ("3", "2"): "<"
    case ("1", "2"), ("4", "5"), ("7", "8"), ("0", "A"), ("8", "9"), ("5", "6"), ("2", "3"): ">"
    default: fatalError()
    }
  }
}

/*
     +---+---+
     | ^ | A |
 +---+---+---+
 | < | v | > |
 +---+---+---+
 */
func DirectionalPad() -> KeyPad {
  KeyPad { character in
    switch character {
    case "A": ["^", ">"]
    case "^": ["v", "A"]
    case "v": ["<", "^", ">"]
    case "<": ["v"]
    case ">": ["v", "A"]
    default: []
    }
  } move: { a, b in
    switch (a, b) {
    case ("v", "^"), (">", "A"): "^"
    case ("^", "v"), ("A", ">"): "v"
    case ("A", "^"), ("v", "<"), (">", "v"): "<"
    case ("^", "A"), ("<", "v"), ("v", ">"): ">"
    default: fatalError()
    }
  }

}

struct KeyPad {

  let neighbors: (Character) -> Set<Character>
  let move: (Character, Character) -> Character

  func directionalSequence(for code: String) -> [String] {
    let code = "A" + code

    let parts = zip(code, code.dropFirst()).map { a, b in

        return pluralAStar(start: a, goal: b, neighbors: neighbors).map { path in
          let sequence = zip(path, path.dropFirst()).reduce(into: "") { sequence, values in
            let (a, b) = values
            sequence.append(move(a, b))
          }

          return sequence + "A"
        }
    }

    return parts.reduce(into: []) { partialResult, part in
      var new: [String] = []
      for string in part {
        if partialResult.isEmpty {
          new.append(string)
        } else {
          for p in partialResult {
            new.append(p + string)
          }
        }
      }
      partialResult = new
    }
  }

  func shortestSequence(codes: [String], indirections: Int, cache: inout [CacheKey: Int]) -> Int {
    var best: Int = .max
    for code in codes {
      guard indirections > 0 else { return code.count }

      assert(code.last == "A")

      let segments = code
        .split(separator: "A", omittingEmptySubsequences: false)
        .dropLast()
        .map { String($0 + "A") }

      let total = segments.reduce(0) { total, segment in
        let key = CacheKey(key: segment, iterations: indirections)

        if let cached = cache[key] {
          return total + cached
        } else {
          let codes = directionalSequence(for: segment)
          let value = shortestSequence(codes: codes, indirections: indirections - 1, cache: &cache)
          cache[key] = value
          return total + value
        }
      }

      best = min(best, total)
    }
    return best
  }
}

struct CacheKey: Hashable {
  let key: String
  let iterations: Int
}

func buttonPresses(for code: String, indirections: Int) -> Int {
  let sequences = NumericPad().directionalSequence(for: code)

  var cache: [CacheKey: Int] = [:]

  return DirectionalPad()
    .shortestSequence(codes: sequences, indirections: indirections, cache: &cache)
}

func sumOfButtonPresses(in input: String, indirections: Int) async -> Int {
  await withTaskGroup(of: Int.self) { group in
    for code in input.split(separator: "\n") {
      group.addTask {
        let presses = buttonPresses(for: String(code), indirections: indirections)
        return presses * Int(code.filter(\.isWholeNumber))!
      }
    }
    return await group.reduce(0, +)
  }
}

public func part1(input: String) async -> Int {
  await sumOfButtonPresses(in: input, indirections: 2)
}

public func part2(input: String) async -> Int {
  await sumOfButtonPresses(in: input, indirections: 25)
}
