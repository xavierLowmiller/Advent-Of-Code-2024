import AOCAlgorithms

enum Instruction: Int {
  /// Division a / combo -> a
  case adv = 0

  /// Bitwise XOR (B and operand) -> b
  case bxl = 1

  /// Combo modulo 8 -> b
  case bst = 2

  /// Jump to operand if a is not zero
  case jnz = 3

  /// Bitwise XOR (B and C) -> b
  case bxc = 4

  /// Output combo modulo 8
  case out = 5

  /// Division a / combo -> b
  case bdv = 6

  /// Division a / combo -> c
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

    a = Int(input.firstMatch(of: /Register A: (\d+)/)!.1)!
    b = Int(input.firstMatch(of: /Register B: (\d+)/)!.1)!
    c = Int(input.firstMatch(of: /Register C: (\d+)/)!.1)!

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

    var nextIp = ip + 2
    defer { ip = nextIp }

    switch instruction {
    case .adv:
      a = a / (2 ^^ combo)
    case .bxl:
      b = b ^ operand
    case .bst:
      b = combo % 8
    case .jnz where a != 0:
      nextIp = operand
    case .jnz:
      break
    case .bxc:
      b = b ^ c
    case .out:
      output.append(combo % 8)
    case .bdv:
      b = a / (2 ^^ combo)
    case .cdv:
      c = a / (2 ^^ combo)
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

    let lowerBound = 8 ^^ (instructions.count - 1)

    var index = instructions.endIndex - 1

    var value = lowerBound

    while index >= instructions.startIndex {
      let incr = 8 ^^ (index - 1)

      let length = instructions.count - index + 1

      var copy = self
      copy.a = value
      var output = copy.run()

      while instructions.suffix(length) != output.suffix(length) {
        value += incr
        var copy = self
        copy.a = value
        output = copy.run()
      }
      index -= 1
    }

    var copy = self
    copy.a = value
    assert(copy.instructions == copy.run())

    return value
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
