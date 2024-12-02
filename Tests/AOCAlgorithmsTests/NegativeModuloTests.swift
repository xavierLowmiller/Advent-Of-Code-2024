import AOCAlgorithms
import Testing

@Test(.tags(.math)) func positiveModulo() {
  #expect(15 %% 12 == 3)
}

@Test(.tags(.math)) func negativeModulo() {
  #expect(-15 %% 12 == 9)
}
