import Day4
import Testing

let testInput = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""

@Test(
  arguments: [
    (testInput, 18),
    (input, nil)
  ]
)
func part1(input: String, expected: Int?) {
  if let expected {
    #expect(part1(input: input) == expected)
  } else {
    print("Part 1:", part1(input: input))
  }
}

@Test(
  arguments: [
    (testInput, 9),
    (input, nil)
  ]
)
func part2(input: String, expected: Int?) {
  if let expected {
    #expect(part2(input: input) == expected)
  } else {
    print("Part 2:", part2(input: input))
  }
}
