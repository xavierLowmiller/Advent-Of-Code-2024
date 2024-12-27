import AOCAlgorithms

struct Computer: Hashable {
  let id: String

  func neighbors(in connections: Set<Connection>) -> Set<Computer> {
    Set(connections
      .filter { $0.contains(self) }
      .map { $0.id1 == self.id ? Computer(id: $0.id2) : Computer(id: $0.id1) })
  }
}

struct Connection: Hashable {
  let id1: String
  let id2: String
}

extension Connection {
  init(_ input: some StringProtocol) {
    let values = input.split(separator: "-")
    id1 = min(String(values[0]), String(values[1]))
    id2 = max(String(values[0]), String(values[1]))
  }

  func contains(_ computer: Computer) -> Bool {
    id1 == computer.id || id2 == computer.id
  }
}

func interconnectedSets(_ connections: some Sequence<Connection>) -> [Set<Computer>] {
  let connections = Set(connections)
  var sets: Set<Set<Computer>> = []

  for c1 in connections {
    for c2 in connections {
      guard c1 != c2 else { continue }
      if c1.id1 == c2.id1, connections.contains(Connection(id1: min(c1.id2, c2.id2), id2: max(c1.id2, c2.id2))) {
        sets.insert([Computer(id: c1.id1), Computer(id: c1.id2), Computer(id: c2.id1), Computer(id: c2.id2)])
      }
      else if c1.id1 == c2.id2, connections.contains(Connection(id1: min(c1.id2, c2.id1), id2: max(c1.id2, c2.id1))) {
        sets.insert([Computer(id: c1.id1), Computer(id: c1.id2), Computer(id: c2.id1), Computer(id: c2.id2)])
      }
      else if c1.id2 == c2.id1, connections.contains(Connection(id1: min(c1.id1, c2.id2), id2: max(c1.id1, c2.id2))) {
        sets.insert([Computer(id: c1.id1), Computer(id: c1.id2), Computer(id: c2.id1), Computer(id: c2.id2)])
      }
      else if c1.id2 == c2.id2, connections.contains(Connection(id1: min(c1.id1, c2.id1), id2: max(c1.id1, c2.id1))) {
        sets.insert([Computer(id: c1.id1), Computer(id: c1.id2), Computer(id: c2.id1), Computer(id: c2.id2)])
      }
    }
  }
  
  assert(sets.allSatisfy({ $0.count == 3 }))
  return Array(sets)
}

public func part1(input: String) -> Int {
  let connections = input.split(separator: "\n").map(Connection.init)
  let sets = interconnectedSets(connections)
  return sets.count(where: { $0.contains(where: { $0.id.first == "t" }) })
}

public func part2(input: String) -> String {
  let connections = Set(input.split(separator: "\n").map(Connection.init))
  let allComputers = Set(connections.flatMap { [Computer(id: $0.id1), Computer(id: $0.id2)] })

  let largestClique = bronKerbosch(p: allComputers) { computer in
    computer.neighbors(in: connections)
  }

  return largestClique.map(\.id).sorted().joined(separator: ",")
}
