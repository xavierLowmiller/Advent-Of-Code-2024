import XCTest
import AOCAlgorithms

final class NegativeModuloTests: XCTestCase {
    func testPositiveModulo() {
        XCTAssertEqual(15 %% 12, 3)
    }

    func testNegativeModulo() {
        XCTAssertEqual(-15 %% 12, 9)
    }
}
