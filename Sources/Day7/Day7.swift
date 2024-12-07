import AOCAlgorithms

enum Operation: CaseIterable, CustomDebugStringConvertible {
  case multiply
  case add
  case concatenate

  var debugDescription: String {
    switch self {
    case .multiply: "*"
    case .add: "+"
    case .concatenate: "||"
    }
  }

  func execute(_ a: Int, _ b: Int) -> Int {
    switch self {
    case .multiply: a * b
    case .add: a + b
    case .concatenate: a ++ b
    }
  }
}

struct Equation {
  var testValue: Int
  var numbers: [Int]

  func canPossiblyBeTrue(operations: [Operation]) -> Bool {
    let count = numbers.count - 1

    let total = operations.count ^^ count

    var abc: [[Operation]] = operations.map { [$0] }
    abc.reserveCapacity(total)

    for _ in 0..<count - 1 {
      let soFar = abc
      var new: [[Operation]] = []

      for op in operations {
        for var ops in soFar {
          ops.append(op)
          new.append(ops)
        }
      }
      abc = new
    }

    assert(total == abc.count)
    assert(abc.allSatisfy { $0.count == count })

    return abc.contains(where: possibleSolution)
  }

  private func possibleSolution(_ operators: some Collection<Operation>) -> Bool {
    assert(operators.count == numbers.count - 1)

    var total = numbers.first!
    for (op, number) in zip(operators, numbers.dropFirst()) {
      total = op.execute(total, number)
      guard total <= testValue else { return false }
    }

    return total == testValue
  }

  init(_ input: some StringProtocol) {
    let parts = input.split(separator: ": ")
    testValue = Int(parts[0])!
    numbers = parts[1].split(separator: " ").compactMap { Int($0) }
  }
}

public func part1(input: String) async -> Int {
  let equations = input.split(separator: "\n").map(Equation.init)

  return await withTaskGroup(of: (Equation, Bool).self, returning: Int.self) { group in
    for equation in equations {
      group.addTask { (equation, equation.canPossiblyBeTrue(operations: [.multiply, .add])) }
    }

    return await group.reduce(0) { $0 + ($1.1 ? $1.0.testValue : 0) }
  }
}

public func part2(input: String) async -> Int {
  let equations = input.split(separator: "\n").map(Equation.init)

  return await withTaskGroup(of: (Equation, Bool).self, returning: Int.self) { group in
    for equation in equations {
      group.addTask { (equation, equation.canPossiblyBeTrue(operations: Operation.allCases)) }
    }

    return await group.reduce(0) { $0 + ($1.1 ? $1.0.testValue : 0) }
  }
}
