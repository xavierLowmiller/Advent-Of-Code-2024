import Day20
import Testing

let testInput = """
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
"""

let cheats1 = [
  2: 14,
  4: 14,
  6: 2,
  8: 4,
  10: 2,
  12: 3,
  20: 1,
  36: 1,
  38: 1,
  40: 1,
  64: 1,
]

let cheats2 = [
  50: 32,
  52: 31,
  54: 29,
  56: 39,
  58: 25,
  60: 23,
  62: 20,
  64: 19,
  66: 12,
  68: 14,
  70: 12,
  72: 22,
  74: 4,
  76: 3,
]

@Test(
  arguments: [
    (testInput, cheats1),
    (input, nil)
  ]
)
func part1(input: String, expected: [Int: Int]?) {
  let result = part1(input: input)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 1:", result.reduce(0) { $0 + ($1.key >= 100 ? $1.value : 0) })
  }
}

@Test(
  arguments: [
    (testInput, cheats2),
    (input, nil)
  ]
)
func part2(input: String, expected: [Int: Int]?) {
  let result = part2(input: input)

  if let expected {
    #expect(result.filter { $0.key >= 50} == expected)
  } else {
    print("Part 2:", result.reduce(0) { $0 + ($1.key >= 100 ? $1.value : 0) })
  }
}
