let input = """
.................#.#............................................#................#........................................#.......
.....#.............................................................#.......#...#........................#...........#.......##....
..........................................................#..#........#..........#...............#.#..................#...........
..#...#..........#....#.....#......................................#......#..#............................#..#....................
.........................#....#.............#....................................#............................................#...
.....................#.......#.............#...#..........#.................#.......#...............#............#......#.........
........#.........#.....................................#............#.....................##...#..#..........#...................
....#...................#.....##......#............#...#........................#...................................#.............
...............................................................................#.......#.....#...#................#.#......##.....
..........................................#............................#.#.................................#.........#............
........#...............#...............#...................##......#..................#...............#..........................
.........................#....................................#..........#.........................................##.............
.......#.................#..................................#......#....................#...............#..........#......#.......
.............#.#...#.............#.............................................#...............................##.....#...#.......
.....................................................#............................................#.........................#.....
.#...#..........................................................##.................................#............#...............#.
...........#..#........#.....#.............#.......#............................................#..............#.................#
......#.#.##...............#.......#......#......................................................................#...............#
...#........#.#.....................##...#...........................#..............................#...................#.........
..............#..#....................#...................#.................##..............#.#........................#..........
...........................................................#.........#.......................#......................#.........#...
................................................#............................................#....................................
..#.....................................................#..............#...#.........#.....#........................#.............
.#..............................#......#..............#........................................................#..................
#......#.....#..#..#........#....................#...........##..............................#..#.....#.....#.....................
.................#.....#.....................#.........#..............................#..............##......................#....
...........................................................#...##..............#..........................#....#..................
........#..#............................#.#........................#.....#................#...#...................................
..........................#........#.......................................................................##...................#.
............#....#.............................................#.......#....#.....#........................................#......
..........#............#....#.......................#.#............#..............................................................
......#...#......................................................#..#.............................................................
.#...#.....#.....#......................................................................................#..........#.....#........
...#..#.............................................................................#.............................................
............#...................#...........................................#..............#.....#.....................#.##.......
.................................................#................................................................................
.........................#.......................................#..................#..............................#..............
................................................................................................................................#.
...#...........................................#........#.................................................#......#................
..#...........................................#.......#.....#.................................#....#.............#...............#
........#..............#...................................................................................#......................
...........#......#............#............#..................................#.........#..............#.........#..........#....
.........................#.........#.....#.................................#..................#...............##..#...............
.....#........#.........................................................#....................................#......#....#........
...#..#.......#......#.#..................#..........................^#...........................................................
....................#.#..........................................................................#...#............................
...........................#..........................................................#...........................................
................#..............................................................................#..................................
...............................#............................................................#...................................#.
..............#..........................................#..............#..................#..........#...........................
................#...#..........................#.##..........#.......#..............................#........#..............#.....
...................#.............#....................#...........................................................................
....#....................................#....#................................................#..#...........#...................
....#.#..............#..........#...................#...................................#....................#........#......#....
...........................#...........#..#......#.......................................#.......................#......#.........
.....................................................................................................#.................#..........
...................................................#.............#..........#..............................#......................
................................#...........##....................................................................#....#..........
...........#.......#.......................................................................#............#.....................#...
.#........#.......#........................................#.#...............................#...#...........................#....
..#...............#................#....#............#................................................................#...........
........#..........#.........#....................................................................................#...............
............................................................................#.............................#...............#......#
......................#................................#.............#...#............#...........................................
................................#.............#.................................................................#..............#..
.........#.#..#...............................#....................................................#.#.......#..#........#........
.............................#.......#.....#......................................................#..#............................
..................#.............................................................................#..........#......................
.....................................#....##.................#......................................#....#........................
#.......................................................................................................................#.........
......#....#..#...........................#..#.....#........................................#..................................#..
.......#.....#...............#....#......#....#..........#.....................#....#..........#.....#..#......................##.
..................#..........#.....#........................................................#............##...................#...
........................#....#............#..................................#....#..#.......#...................................#
.....#............................#...............................#..#...................#.....#..#........#....#.#...............
......#...#..#......#..........................#........#....................#.......#...........#..........................#..#..
.....#.............................................................................................#......#......................#
...........................................#......................................................................................
.....#...........................#.#.#............................#..................#............................#.......#.......
........#.......................................................#...................#.......#.....................................
...............#..................................................#.................................................#.............
..##............................................................#..............................................................#..
.......#..................................#......................#.................................#...................#..........
......#.........#..............#....##........#....#................................#.....................................#......#
................#.....................................................................................#.............#.............
#..#..#......#.#.....#..#.................................................................................................#..#....
.....................#.....#................................................#.......#........#.................#........#.#...#...
..................................................................#....#..#...................#................................#..
........................#...........#.......................................................#..#..................................
.#.......#...................................................#..............#.......#...#.........................................
.......##...............#.............................#...........................#...............................................
....#............#....#...#........................#...........................#.#.....#..........................................
...........................#............................#..#..................#...........................#...#...................
...........#.#.............#..........#...........................................................................................
.............#..........#...............#...##.........................#..............#...#.............#..#......................
..................#.....#............#..#.........#...............................................................................
...........................................................#.....#..................#.......................#..#..................
....................................#....#.......##............#.............................#...............#...........#........
......#....................#..................#..........................................#...............................#.#......
......................#...........................................#.....#.................................................#....#..
.....................................#...............#....................................#.....#.............#......##...........
......................#...............................................................##.#..........#....#..................#.....
...........#.............#......................#....................#..................................#......#...........##.....
.....#.#...#......................................................................................................................
.........#.....................................#................#.............#....#......................#..........#............
......##.#.................#...............#..##.......................#...............#.......................................#..
....................#.........#.......#....#..................................#..........................#..............#.........
......................#....#..#..#................................#.......#.......................................................
.........................................##............................##..#..................#..................#...........#....
...................#..................................#................................................................#..........
.#.............#....................................................................................#.............................
......................................#.....#.............#..#............................................#...#............#......
.....................................#..................................#...#.......................##...................#........
...........................................................#...................................................#...........#......
.............................#.......#.......................................#.........................#.....................#...#
.....................#............................................................................................................
#....#.......................................#.........#........#...................................#.....#.........#........#....
.......................................................#......#................................##.#........#.........#..........#.
.........#........................##.....#.............................................................#.................#..#.....
....##....................................................................................................#...#...#...............
.......#.....#.......#.............#........#...............##.#......#...............#.................#..#.........#...#....#...
....................#.................................#........................................................................#..
#...............#....................................#.........#...............................#..#..........##...#...#......#....
............#........................#.....#...#.........#.........#..#......................................#....................
..........#.......#.#.....................#...........#...................#.##....................#..#...#........#..............#
.......................................#.......#........#.....#...........................................#.......#......#........
...............................#.........#..............#......................#..........................................#.#.....
............#........#.............................................#.....................................................##......#
......#.#............................................................................#......#.....#......#................#.......
.........#.............#................#.................#..###..........#.........................#.#....#......................
"""
