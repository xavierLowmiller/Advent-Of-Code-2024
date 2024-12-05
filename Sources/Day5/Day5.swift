struct Rule {
  let first: Int
  let second: Int

  init(_ input: some StringProtocol) {
    first = Int(input.split(separator: "|").first!)!
    second = Int(input.split(separator: "|").last!)!
  }
}

struct Update {
  let pageNumbers: [Int]

  var middlePage: Int {
    pageNumbers[pageNumbers.count / 2]
  }

  func isValid(_ rules: some Sequence<Rule>) -> Bool {
    rules.allSatisfy(ruleApplies)
  }

  private func ruleApplies(_ rule: Rule) -> Bool {
    if let index1 = pageNumbers.firstIndex(of: rule.first),
       let index2 = pageNumbers.firstIndex(of: rule.second) {
      return index1 < index2
    } else {
      return true
    }
  }

  func sorted(_ rules: some Sequence<Rule>) -> Update {
    var pageNumbers = pageNumbers
    let rulesThatApply = rules.filter {
      pageNumbers.contains($0.first) && pageNumbers.contains($0.second)
    }

    pageNumbers.sort { a, b in
      if let rule = rulesThatApply.first(where: {
        $0.first == a && $0.second == b || $0.first == b && $0.second == a
      }) {
        return rule.first == a && rule.second == b
      } else {
        return true
      }
    }

    let newUpdate = Update(pageNumbers: pageNumbers)
    assert(newUpdate.isValid(rules))

    return newUpdate
  }

  init(_ input: some StringProtocol) {
    pageNumbers = input.split(separator: ",").compactMap { Int($0) }
  }

  init(pageNumbers: [Int]) {
    self.pageNumbers = pageNumbers
  }
}

struct SafetyManual {
  let rules: [Rule]
  let updates: [Update]

  init(_ input: String) {
    rules = input.split(separator: "\n\n").first!.split(separator: "\n").map(Rule.init)
    updates = input.split(separator: "\n\n").last!.split(separator: "\n").map(Update.init)
  }

  var checkSumOfSortedUpdatesCorrectly: Int {
    updates
      .filter { $0.isValid(rules) }
      .reduce(0) { $0 + $1.middlePage }
  }

  var checkSumOfSortedUpdatesIncorrectly: Int {
    updates
      .filter { !$0.isValid(rules) }
      .map { $0.sorted(rules) }
      .map { print($0.pageNumbers); return $0 }
      .reduce(0) { $0 + $1.middlePage }
  }
}

public func part1(input: String) -> Int {
  let manual = SafetyManual(input)
  return manual.checkSumOfSortedUpdatesCorrectly
}

public func part2(input: String) -> Int {
  let manual = SafetyManual(input)
  return manual.checkSumOfSortedUpdatesIncorrectly
}
