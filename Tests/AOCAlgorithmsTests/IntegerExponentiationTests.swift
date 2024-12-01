import XCTest
import AOCAlgorithms

final class IntegerExponentiationTests: XCTestCase {
    func testIntegerExponentiation() {
        XCTAssertEqual(2 ^^ 4, 16)
        XCTAssertEqual(4 ^^ 3, 64)
        XCTAssertEqual(2 ^^ 0, 1)
        XCTAssertEqual(0 ^^ 325, 0)
    }
}
