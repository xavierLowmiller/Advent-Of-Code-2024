/// The Least Common Multiple of two integers
public func lcm(_ a: Int, _ b: Int) -> Int {
    guard a != 0 && b != 0 else { return 0 }

    return abs(a * (b / gcd(a, b)))
}
