import Day7
import Testing

let testInput = """
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"""

@Test(
  arguments: [
    (testInput, 3749),
    (input, nil)
  ]
)
func part1(input: String, expected: Int?) async {
  let result = await part1(input: input)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 1:", result)
  }
}

@Test(
  arguments: [
    (testInput, 11387),
    (input, nil)
  ]
)
func part2(input: String, expected: Int?) async {
  let result = await part2(input: input)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 2:", result)
  }
}

