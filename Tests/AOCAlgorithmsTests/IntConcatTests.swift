import AOCAlgorithms
import Testing

@Test(
  .tags(.math),
  arguments: [
    (12, 34, 1234),
    (123, 345, 123345),
    (9999999, 100000000, 9999999100000000),
    (00000000, 9999999, 9999999),
  ]
)
func concatenations(value: (a: Int, b: Int, expected: Int)) {
  #expect(value.a ++ value.b == value.expected)
}
