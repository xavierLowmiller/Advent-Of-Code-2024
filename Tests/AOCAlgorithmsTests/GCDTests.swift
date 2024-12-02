import AOCAlgorithms
import Testing

@Suite(.tags(.math)) struct GCDTests {
  @Test func GCD() {
    let a = 18
    let b = 27

    #expect(gcd(a, b) == 9)
  }

  @Test func GCDWithZero() {
    let a = 0
    let b = 27

    #expect(gcd(a, b) == 27)
  }

  @Test func GCDWithOne() {
    let a = 1
    let b = 27

    #expect(gcd(a, b) == 1)
  }

  @Test func GCDWithZeroes() {
    let a = 0
    let b = 0

    #expect(gcd(a, b) == 0)
  }

  @Test func GCDWithPrimes() {
    let a = 3
    let b = 17

    #expect(gcd(a, b) == 1)
  }

  @Test func GCDWithNegativeNumbers() {
    let a = -3
    let b = 15

    #expect(gcd(a, b) == 3)
  }
}
