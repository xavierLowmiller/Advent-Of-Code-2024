import XCTest
import AOCAlgorithms

final class LCMTests: XCTestCase {
    func testLCM() {
        let a = 18
        let b = 27

        XCTAssertEqual(lcm(a, b), 54)
    }

    func testLCMWithZero() {
        let a = 0
        let b = 27

        XCTAssertEqual(lcm(a, b), 0)
    }

    func testLCMWithZeroes() {
        let a = 0
        let b = 0

        XCTAssertEqual(lcm(a, b), 0)
    }

    func testLCMWithPrimes() {
        let a = 3
        let b = 17

        XCTAssertEqual(lcm(a, b), 51)
    }

    func testLCMWithNegativeNumbers() {
        let a = -3
        let b = 17

        XCTAssertEqual(lcm(a, b), 51)
    }
}
