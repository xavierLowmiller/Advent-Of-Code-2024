import Day14
import Testing

let testInput = """
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
"""

@Test(
  arguments: [
    (testInput, (11, 7), 12),
    (input, (101, 103), nil)
  ]
)
func part1(input: String, size: Size, expected: Int?) {
  let result = part1(input: input, size: size)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 1:", result)
  }
}

@Test func part2() {
  print("Part 2:", part2(input: input, size: (101, 103)))
}
