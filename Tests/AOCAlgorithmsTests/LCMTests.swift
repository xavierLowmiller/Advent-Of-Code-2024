import AOCAlgorithms
import Testing

@Suite(.tags(.math)) struct LCMTests {
  @Test func LCM() {
    let a = 18
    let b = 27

    #expect(lcm(a, b) == 54)
  }

  @Test func LCMWithZero() {
    let a = 0
    let b = 27

    #expect(lcm(a, b) == 0)
  }

  @Test func LCMWithZeroes() {
    let a = 0
    let b = 0

    #expect(lcm(a, b) == 0)
  }

  @Test func LCMWithPrimes() {
    let a = 3
    let b = 17

    #expect(lcm(a, b) == 51)
  }

  @Test func LCMWithNegativeNumbers() {
    let a = -3
    let b = 17

    #expect(lcm(a, b) == 51)
  }
}
