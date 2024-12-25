import Foundation

struct Gate: CustomDebugStringConvertible, Hashable {
  var input1: String
  var input2: String
  var output: String
  var kind: Kind

  enum Kind {
    case and, or, xor

    init(_ kind: some StringProtocol) {
      switch kind {
      case "AND": self = .and
      case "OR": self = .or
      case "XOR": self = .xor
      default: fatalError()
      }
    }
  }

  func output(_ a: Bool, b: Bool) -> Bool {
    switch kind {
    case .and:
      a && b
    case .or:
      a || b
    case .xor:
      a != b
    }
  }

  var debugDescription: String {
    let op = switch kind {
    case .and: "AND"
    case .or: "OR"
    case .xor: "XOR"
    }

    return "\(input1) \(op) \(input2) -> \(output)"
  }
}

private func parse(_ input: String) -> (values: [String: Bool], gates: [Gate]) {
  let parts = input.split(separator: "\n\n")
  let values: [String: Bool] = Dictionary(uniqueKeysWithValues: parts[0].split(separator: "\n").map { line in
    let values = line.split(separator: ": ")
    return (String(values[0]), values[1] == "1")
  })

  let gates: [Gate] = parts[1].split(separator: "\n").compactMap { line in
    guard let output = line.wholeMatch(of: /(.+) (.+) (.+) -> (.+)/)?.output
    else { return nil }

    return Gate(
      input1: min(String(output.1), String(output.3)),
      input2: max(String(output.1), String(output.3)),
      output: String(output.4),
      kind: Gate.Kind(output.2)
    )
  }
  return (values, gates)
}

func compute(_ input: String) -> Int {
  let (values, gates) = parse(input)
  return compute(values: values, gates: gates)
}
func compute(values: [String: Bool], gates: [Gate]) -> Int {
  var values = values

  let allZeds = gates.compactMap { $0.output.first == "z" ? $0.output : nil }

  var gatesToCheck = gates.filter { values[$0.output] == nil }

  while !allZeds.allSatisfy({ values[$0] != nil }) {
    for gate in gatesToCheck {
      assert(values[gate.output] == nil)
      if let value1 = values[gate.input1], let value2 = values[gate.input2] {
        values[gate.output] = gate.output(value1, b: value2)
      }
    }
    gatesToCheck.removeAll { values[$0.output] != nil }
  }

  let string = allZeds
    .sorted(by: >)
    .compactMap { (values[$0] == true) ? "1" : "0" }
    .joined()

  return Int(string, radix: 2)!
}

public func part1(input: String) -> Int {
  return compute(input)
}

public func part2(input: String) -> String {
  let (values, gates) = parse(input)

  let numbers = Int(values.keys.filter { $0.hasPrefix("x") }.max()!.dropFirst())!

  // Build working adder
  var carry: String?
  var expected: [Gate] = []
  for i in 0...numbers {
    let xInput = String(format: "x%02d", i)
    let yInput = String(format: "y%02d", i)
    let zOutput = String(format: "z%02d", i)
    let intermediary1 = String(format: "i1%02d", i)
    let intermediary2 = String(format: "i2%02d", i)
    let intermediary3 = String(format: "i3%02d", i)
    let next = String(format: "n%02d", i)

    if let carry {
      expected.append(Gate(input1: xInput, input2: yInput, output: intermediary1, kind: .and))
      expected.append(Gate(input1: xInput, input2: yInput, output: intermediary2, kind: .xor))
      expected.append(Gate(input1: intermediary2, input2: carry, output: intermediary3, kind: .and))
      expected.append(Gate(input1: intermediary2, input2: carry, output: zOutput, kind: .xor))
      expected.append(Gate(input1: intermediary1, input2: intermediary3, output: numbers == i ? "z\(i + 1)": next, kind: .or))
    } else {
      expected.append(Gate(input1: xInput, input2: yInput, output: next, kind: .and))
      expected.append(Gate(input1: xInput, input2: yInput, output: zOutput, kind: .xor))
    }
    carry = next
  }

  // Compare to existing graph

  var gatesToMatch = expected
  var lookup: [String: String] = [:]
  while gatesToMatch.contains(where: { $0.input1.wholeMatch(of: /i\d\d\d/) != nil })
          || gatesToMatch.contains(where: { $0.input2.wholeMatch(of: /i\d\d\d/) != nil })  {

    for gate in gatesToMatch {
      guard let correspondingGate = gates.first(where: {
        $0.input1 == gate.input1 && $0.input2 == gate.input2 && $0.kind == gate.kind
      }) else { continue }

      if lookup[gate.output] == nil {
        lookup[gate.output] = correspondingGate.output
      } else {
        assert(lookup[gate.output] == correspondingGate.output)
      }
    }

    gatesToMatch = gatesToMatch.map {
      var gate = $0
      gate.input1 = lookup[gate.input1] ?? gate.input1
      gate.input2 = lookup[gate.input2] ?? gate.input2
      gate.output = lookup[gate.output] ?? gate.output
      return gate
    }
  }

  let mismatches = gatesToMatch.filter { !gates.contains($0) }

  let x = Int(values.keys
    .filter { $0.first == "x" }
    .sorted(by: >)
    .compactMap { (values[$0] == true) ? "1" : "0" }
    .joined(),
              radix: 2)!

  let y = Int(values.keys
    .filter { $0.first == "y" }
    .sorted(by: >)
    .compactMap { (values[$0] == true) ? "1" : "0" }
    .joined(),
              radix: 2)!

  let z = x + y

  assert(z == compute(values: values, gates: expected))



  return ""
}
