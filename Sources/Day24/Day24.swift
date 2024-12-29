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

  func output(_ a: Bool, _ b: Bool) -> Bool {
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
  var gatesToCheck = gates.filter { values[$0.output] == nil }

  while !gatesToCheck.isEmpty {
    let gate = gatesToCheck.removeFirst()
    guard let value1 = values[gate.input1], let value2 = values[gate.input2]
    else {
      gatesToCheck.append(gate)
      continue
    }

    values[gate.output] = gate.output(value1, value2)
  }

  let string = gates
    .compactMap { $0.output.first == "z" ? $0.output : nil }
    .sorted(by: >)
    .map { (values[$0] == true) ? "1" : "0" }
    .joined()

  return Int(string, radix: 2)!
}

public func part1(input: String) -> Int {
  return compute(input)
}

public func part2(input: String) -> String {
  let (_, gates) = parse(input)

  let highestZ = gates.map(\.output).max()!

  var wrong: Set<String> = []

  for gate in gates {
    // Gates that output (prefix: z) must always be XOR (except at the end)
    if gate.output.hasPrefix("z"), gate.kind != .xor, gate.output != highestZ {
      wrong.insert(gate.output)
    }

    // XOR gates: Must either go from xy to intermediary or to z
    // (but never between intermediaries)
    if gate.kind == .xor,
       gate.output.firstMatch(of: /[xyz]/) == nil,
       gate.input1.firstMatch(of: /[xyz]/) == nil,
       gate.input2.firstMatch(of: /[xyz]/) == nil {
      wrong.insert(gate.output)
    }

    // AND gates: Must *always* be followed by an OR gate
    if gate.kind == .and, gate.input1 != "x00" {
      for next in gates {
        if gate.output == next.input1 || gate.output == next.input2,
           next.kind != .or {
          wrong.insert(gate.output)
        }
      }
    }

    // XOR gates: Must *never* be followed by an OR gate
    if gate.kind == .xor {
      for next in gates {
        if gate.output == next.input1 || gate.output == next.input2,
           next.kind == .or {
          wrong.insert(gate.output)
        }
      }
    }
  }

  return wrong.sorted().joined(separator: ",")
}
