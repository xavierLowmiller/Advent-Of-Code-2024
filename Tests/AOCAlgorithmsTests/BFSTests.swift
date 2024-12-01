import XCTest
import AOCAlgorithms

final class BFSTests: XCTestCase {
    func testBFS() throws {

        let p1 = try XCTUnwrap(bfs(
            start: City.frankfurt,
            goal: .augsburg,
            neighbors: { City.neighbors[$0]!.map(\.0) }
        ))

        XCTAssertEqual(p1, [.frankfurt, .mannheim, .karlsruhe, .augsburg])

        let p2 = try XCTUnwrap(bfs(
            start: City.frankfurt,
            goal: .stuttgart,
            neighbors: { City.neighbors[$0]!.map(\.0) }
        ))

        XCTAssertEqual(p2, [.frankfurt, .wuerzburg, .nuernberg, .stuttgart])
    }
}

private enum City: String {
    case augsburg = "Augsburg"
    case erfurt = "Erfurt"
    case frankfurt = "Frankfurt"
    case karlsruhe = "Karlsruhe"
    case kassel = "Kassel"
    case mannheim = "Mannheim"
    case muenchen = "München"
    case nuernberg = "Nürnberg"
    case stuttgart = "Stuttgart"
    case wuerzburg = "Würzburg"

    static let neighbors: [City: [(City, Int)]] = [
        .frankfurt: [
            (.mannheim, 85),
            (.wuerzburg, 217),
            (.kassel, 173),
        ],
        .mannheim: [
            (.frankfurt, 85),
            (.karlsruhe, 80),
        ],
        .karlsruhe: [
            (.mannheim, 80),
            (.augsburg, 250),
        ],
        .augsburg: [
            (.karlsruhe, 250),
            (.muenchen, 84),
        ],
        .muenchen: [
            (.augsburg, 84),
            (.nuernberg, 167),
            (.kassel, 502),
        ],
        .kassel: [
            (.frankfurt, 173),
            (.muenchen, 502),
        ],
        .nuernberg: [
            (.muenchen, 167),
            (.stuttgart, 183),
            (.wuerzburg, 103),
        ],
        .stuttgart: [
            (.nuernberg, 183),
        ],
        .wuerzburg: [
            (.nuernberg, 103),
            (.frankfurt, 217),
            (.erfurt, 186),
        ],
        .erfurt: [
            (.wuerzburg, 186),
        ],
    ]
}
