import Day18
import Testing

let testInput = """
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
"""

@Test(
  arguments: [
    (testInput, 6, 12, 22),
    (input, 70, 1024, nil)
  ]
)
func part1(input: String, gridSize: Int, bytes: Int, expected: Int?) {
  let result = part1(input: input, gridSize: gridSize, bytes: bytes)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 1:", result)
  }
}

@Test(
  arguments: [
    (testInput, 6, Point(x: 6, y: 1)),
    (input, 70, nil)
  ]
)
func part2(input: String, gridSize: Int, expected: Point?) {
  let result = part2(input: input, gridSize: gridSize)

  if let expected {
    #expect(result == expected)
  } else {
    print("Part 2:", result)
  }
}
