 @testable import Marvel
 import XCTest
 
 class CharacterDetailsBuilderTests: XCTestCase {
    func testBuild() {
        let builder = CharacterDetailsBuilder()
        let view = builder.build(characterId: 12445)
        XCTAssertNotNil(view.presenter)
        XCTAssertNotNil(builder.presenter)
    }
 }
