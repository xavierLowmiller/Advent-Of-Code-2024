import AOCAlgorithms

enum Instruction: Int {
  /// Division (A)
  case adv = 0
  /// Bitwise XOR
  case bxl = 1
  /// Modulo
  case bst = 2
  /// Jump if not zero
  case jnz = 3
  /// Bitwise XOR (B and C)
  case bxc = 4
  /// Output
  case out = 5
  /// Division (B)
  case bdv = 6
  /// Division (C)
  case cdv = 7
}

struct Computer {
  var a: Int
  var b: Int
  var c: Int
  var ip = 0
  var output: [Int] = []

  let instructions: [Int]

  init(_ input: String) {

    let matchA = input.firstMatch(of: /Register A: (\d+)/)!
    a = Int(matchA.1)!

    let matchB = input.firstMatch(of: /Register B: (\d+)/)!
    b = Int(matchB.1)!

    let matchC = input.firstMatch(of: /Register C: (\d+)/)!
    c = Int(matchC.1)!

    instructions = input
      .split(separator: "Program: ")[1]
      .split(separator: ",")
      .map { Int($0)! }
  }

  mutating func execute(instruction: Instruction, operand: Int) {
    let combo: Int
    switch operand {
    case 0...3:
      combo = operand
    case 4:
      combo = a
    case 5:
      combo = b
    case 6:
      combo = c
    default:
      fatalError()
    }

    switch instruction {
    case .adv:
      a = a / (2 ^^ combo)
      ip += 2
    case .bxl:
      b = b ^ operand
      ip += 2
    case .bst:
      b = combo % 8
      ip += 2
    case .jnz:
      if a == 0 {
        ip += 2
      } else {
        ip = operand
      }
    case .bxc:
      b = b ^ c
      ip += 2
    case .out:
      output.append(combo % 8)
      ip += 2
    case .bdv:
      b = a / (2 ^^ combo)
      ip += 2
    case .cdv:
      c = a / (2 ^^ combo)
      ip += 2
    }
  }

  mutating func run() -> [Int] {
    while ip < instructions.count {
      let instruction = Instruction(rawValue: instructions[ip])!
      execute(instruction: instruction, operand: instructions[ip + 1])
    }
    return output
  }

  var selfCopyValue: Int {
    for a in 0... {
      var copy = self
      copy.a = a
      if copy.instructions == copy.run() {
        return a
      }
    }
    return -1
  }
}

public func part1(input: String) -> [Int] {
  var computer = Computer(input)
  return computer.run()
}

public func part2(input: String) -> Int {
  let computer = Computer(input)
  return computer.selfCopyValue
}
