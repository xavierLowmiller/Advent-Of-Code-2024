import Day6
import Testing

let testInput = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""

@Test(
  arguments: [
    (testInput, 41),
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
    (testInput, 6),
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
