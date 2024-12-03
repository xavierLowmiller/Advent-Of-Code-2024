public func part1(input: String) -> Int {
  let pattern = /mul\((\d+),(\d+)\)/

  var total = 0
  for match in input.matches(of: pattern) {
    total += Int(match.1)! * Int(match.2)!
  }
  return total
}

public func part2(input: String) -> Int {
  let pattern = /mul\((\d+),(\d+)\)/
  var input = input[...]

  var total = 0
  var isOn = true

  while !input.isEmpty {

    // Enable instructions
    if input.hasPrefix("do()") {
      isOn = true
      input.removeFirst(4)
      continue
    }

    // Enable instructions
    if input.hasPrefix("don't()") {
      isOn = false
      input.removeFirst(7)
      continue
    }

    guard isOn else {
      input.removeFirst()
      continue
    }

    if let match = input.prefixMatch(of: pattern) {
      total += Int(match.1)! * Int(match.2)!
      input.removeFirst(match.0.count)
      continue
    }
    
    input.removeFirst()
  }

  return total
}
