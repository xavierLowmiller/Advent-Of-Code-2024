/// The Bron-Kerbosch algorithm. It finds the maximal clique(s)
/// (fully interconnected nodes) in an arbitrary graph.
///
/// - Parameters:
///   - r: The potentially maximal clique. Mainly used for recursion.
///   - p: All initial nodes in the set
///   - x: Used for recursion
///   - neighbors: Description of the neighbors of a given node.
/// - Returns: The largest clique.
public func bronKerbosch<Value: Hashable, S: Sequence>(
  r: Set<Value> = [],
  p: Set<Value>,
  x: Set<Value> = [],
  neighbors: (Value) -> S
) -> Set<Value> where S.Element == Value {
  if p.isEmpty && x.isEmpty {
    return r
  }

  var p = p
  var x = x
  var options: [Set<Value>] = []

  let pivot = p.union(x).randomElement()!
  for v in p.subtracting(neighbors(pivot)) {
    let n = neighbors(v)
    options.append(bronKerbosch(
      r: r.union([v]),
      p: p.intersection(n),
      x: x.intersection(n),
      neighbors: neighbors
    ))
    p.remove(v)
    x.insert(v)
  }

  return options.max(by: { $0.count < $1.count }) ?? []
}
