import Day2
import Testing

let testInput = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

@Test(arguments: [
  (testInput, 2),
  (input, nil)
])
func part1(input: String, expected: Int?) {
  if let expected {
    #expect(part1(input: input) == expected)
  } else {
    print("Part 1:", part1(input: input))
  }
}

@Test(arguments: [
  (testInput, 4),
  (input, nil)
])
func part2(input: String, expected: Int?) {
  if let expected {
    #expect(part2(input: input) == expected)
  } else {
    print("Part 2:", part2(input: input))
  }
}
