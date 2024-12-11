import Day11
import Testing

let testInput = """
125 17
"""

@Test(
  arguments: [
    (testInput, 1, 3),
    (testInput, 2, 4),
    (testInput, 3, 5),
    (testInput, 4, 9),
    (testInput, 5, 13),
    (testInput, 6, 22),
    (testInput, 25, 55312),
    (input, 25, nil)
  ]
)
func part1(input: String, blinks: Int, expected: Int?) {
  let result = part1(input: input, blinks: blinks)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 1:", result)
  }
}

@Test
func part2() {
  let result = part1(input: input, blinks: 75)
  print("Part 2:", result)
}
