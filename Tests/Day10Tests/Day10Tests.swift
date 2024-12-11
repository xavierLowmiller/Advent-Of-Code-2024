import Day10
import Testing

let testInput1 = """
0123
1234
8765
9876
"""

let testInput2 = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""

@Test(
  arguments: [
    (testInput1, 1),
    (testInput2, 36),
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
    (testInput2, 81),
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


