import Day1
import Testing

let testInput = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

@Test(arguments: [
  (testInput, 11),
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
  (testInput, 31),
  (input, nil)
])
func part2(input: String, expected: Int?) {
  if let expected {
    #expect(part2(input: input) == expected)
  } else {
    print("Part 2:", part2(input: input))
  }
}
