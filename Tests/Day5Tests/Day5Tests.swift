import Day5
import Testing

let testInput = """
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"""

@Test(
  arguments: [
    (testInput, 143),
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
    (testInput, 123),
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
