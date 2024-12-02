import AOCAlgorithms
import Testing

@Test(.tags(.math)) func integerSquareRoot() {
  #expect(4.squareRoot() == 2)
  #expect(-9.squareRoot() == -3)
  #expect(100.squareRoot() == 10)
  #expect(101.squareRoot() == 10)
}
