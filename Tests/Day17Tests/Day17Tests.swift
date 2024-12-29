import Day17
import Testing

let testInput1 = """
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
"""

let testInput2 = """
Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0
"""

@Test(
  arguments: [
    (testInput1, [4, 6, 3, 5, 6, 3, 5, 2, 1, 0]),
    (input, nil)
  ]
)
func part1(input: String, expected: [Int]?) {
  let result = part1(input: input)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 1:", result.map { "\($0)" }.joined(separator: ",") )
  }
}

@Test(
  arguments: [
    (testInput2, 117440),
    (input, nil as Int?)
  ]
)
func part2(input: String, expected: Int?) {
  let result = part2(input: input)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 2:", result)
  }
}
