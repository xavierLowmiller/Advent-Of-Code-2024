@testable import Day12
import Testing

let testInput1 = """
AAAA
BBCD
BBCC
EEEC
"""

let testInput2 = """
OOOOO
OXOXO
OOOOO
OXOXO
OOOOO
"""

let testInput3 = """
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
"""

let testInput4 = """
EEEEE
EXXXX
EEEEE
EXXXX
EEEEE
"""

let testInput5 = """
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA
"""

@Test(
  arguments: [
    (testInput1, 140),
    (testInput2, 772),
    (testInput3, 1930),
    (input, nil)
  ]
)
func part1(input: String, expected: Int?) {
  let result = part1(input: input)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 1:", result)
  }
}

@Test(
  arguments: [
    (testInput1, 80),
    (testInput2, 436),
    (testInput3, 1206),
    (testInput4, 236),
    (testInput5, 368),
    (input, nil)
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
