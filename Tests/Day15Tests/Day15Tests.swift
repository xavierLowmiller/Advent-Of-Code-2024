@testable import Day15
import Testing

let testInput1 = """
########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<
"""

let testInput2 = """
##########
#..O..O.O#
#......O.#
#.OO..O.O#
#..O@..O.#
#O#..O...#
#O..O..O.#
#.OO.O.OO#
#....O...#
##########

<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
"""

@Test(
  arguments: [
    (testInput1, 2028),
    (testInput2, 10092),
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
    (testInput2, 9021),
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

@Test func warehouseSingleMoves() {
  var warehouse = Warehouse(testInput1, wide: false)

  let after1 = """
  ########
  #..O.O.#
  ##@.O..#
  #...O..#
  #.#.O..#
  #...O..#
  #......#
  ########
  
  <^^>>>vv<v>>v<<
  """

  warehouse.move(in: .left)
  #expect(warehouse == Warehouse(after1, wide: false))

  let after2 = """
  ########
  #.@O.O.#
  ##..O..#
  #...O..#
  #.#.O..#
  #...O..#
  #......#
  ########
  
  <^^>>>vv<v>>v<<
  """

  warehouse.move(in: .up)
  #expect(warehouse == Warehouse(after2, wide: false))

  let after3 = """
  ########
  #.@O.O.#
  ##..O..#
  #...O..#
  #.#.O..#
  #...O..#
  #......#
  ########
  
  <^^>>>vv<v>>v<<
  """

  warehouse.move(in: .up)
  #expect(warehouse == Warehouse(after3, wide: false))

  let after4 = """
  ########
  #..@OO.#
  ##..O..#
  #...O..#
  #.#.O..#
  #...O..#
  #......#
  ########
  
  <^^>>>vv<v>>v<<
  """

  warehouse.move(in: .right)
  #expect(warehouse == Warehouse(after4, wide: false))

  let after5 = """
  ########
  #...@OO#
  ##..O..#
  #...O..#
  #.#.O..#
  #...O..#
  #......#
  ########
  
  <^^>>>vv<v>>v<<
  """

  warehouse.move(in: .right)
  #expect(warehouse == Warehouse(after5, wide: false))
}

@Test func warehouseSingleWideMoves() {
  let testInput = """
  #######
  #...#.#
  #.....#
  #..OO@#
  #..O..#
  #.....#
  #######
  
  <vv<<^^<<^^
  """

  var warehouse = Warehouse(testInput, wide: true)

  let expected1 = """
  ##############
  ##......##..##
  ##..........##
  ##...[][]@..##
  ##....[]....##
  ##..........##
  ##############
  """

  warehouse.wideMove(in: .left)
  #expect(warehouse.debugDescription == expected1)

  let expected2 = """
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[].@..##
  ##..........##
  ##############
  """

  warehouse.wideMove(in: .down)
  #expect(warehouse.debugDescription == expected2)

  let expected3 = """
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[]....##
  ##.......@..##
  ##############
  """

  warehouse.wideMove(in: .down)
  #expect(warehouse.debugDescription == expected3)

  let expected4 = """
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[]....##
  ##......@...##
  ##############
  """

  warehouse.wideMove(in: .left)
  #expect(warehouse.debugDescription == expected4)

  let expected5 = """
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[]....##
  ##.....@....##
  ##############
  """

  warehouse.wideMove(in: .left)
  #expect(warehouse.debugDescription == expected5)

  let expected6 = """
  ##############
  ##......##..##
  ##...[][]...##
  ##....[]....##
  ##.....@....##
  ##..........##
  ##############
  """

  warehouse.wideMove(in: .up)
  #expect(warehouse.debugDescription == expected6)

  let expected7 = """
  ##############
  ##......##..##
  ##...[][]...##
  ##....[]....##
  ##.....@....##
  ##..........##
  ##############
  """

  warehouse.wideMove(in: .up)
  #expect(warehouse.debugDescription == expected7)
}
