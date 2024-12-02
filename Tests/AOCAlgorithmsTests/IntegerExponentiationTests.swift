import AOCAlgorithms
import Testing

@Test(.tags(.math)) func integerExponentiation() {
  #expect(2 ^^ 4 == 16)
  #expect(4 ^^ 3 == 64)
  #expect(2 ^^ 0 == 1)
  #expect(0 ^^ 325 == 0)
}
