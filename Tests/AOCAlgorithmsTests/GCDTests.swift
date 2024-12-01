import XCTest
import AOCAlgorithms

final class GCDTests: XCTestCase {
    func testGCD() {
        let a = 18
        let b = 27

        XCTAssertEqual(gcd(a, b), 9)
    }

    func testGCDWithZero() {
        let a = 0
        let b = 27

        XCTAssertEqual(gcd(a, b), 27)
    }

    func testGCDWithOne() {
        let a = 1
        let b = 27

        XCTAssertEqual(gcd(a, b), 1)
    }

    func testGCDWithZeroes() {
        let a = 0
        let b = 0

        XCTAssertEqual(gcd(a, b), 0)
    }

    func testGCDWithPrimes() {
        let a = 3
        let b = 17

        XCTAssertEqual(gcd(a, b), 1)
    }

    func testGCDWithNegativeNumbers() {
        let a = -3
        let b = 15

        XCTAssertEqual(gcd(a, b), 3)
    }
}
