import Day9
import Testing

let testInput = """
2333133121414131402
"""

@Test(
  arguments: [
    (testInput, 1928),
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
    (testInput, 2858),
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

