import Day22
import Testing

let testInput1 = """
1
10
100
2024
"""

let testInput2 = """
1
2
3
2024
"""

@Test(
  arguments: [
    (testInput1, 37327623),
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
    (testInput2, 23),
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
