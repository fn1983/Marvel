@testable import Marvel
import XCTest

class CharacterListBuilderTests: XCTestCase {
    func testBuild() {
        let builder = CharacterListBuilder()
        let view = builder.build()
        XCTAssertNotNil(view.presenter)
        XCTAssertNotNil(builder.presenter)
    }
}
