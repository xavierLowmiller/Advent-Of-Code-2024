/// The Greatest Common Denominator of two integers
public func gcd(_ a: Int, _ b: Int) -> Int {
    var (a, b) = (abs(a), abs(b))
    (a, b) = (max(a, b), min(a, b))
    while b > 0 {
        (a, b) = (b, a %% b)
    }

    return a
}
