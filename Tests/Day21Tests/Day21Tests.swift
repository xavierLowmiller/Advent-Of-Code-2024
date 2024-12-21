import Day21
import Testing

let testInput = """
029A
980A
179A
456A
379A
"""

@Test(
  arguments: [
    (testInput, 126384),
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

@Test
func part2() async {
  let result = await part2(input: input)
  print("Part 2:", result)
}
