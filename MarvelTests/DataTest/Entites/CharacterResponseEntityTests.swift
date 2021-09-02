@testable import Marvel
import XCTest

class CharacterResponseEntityTests: XCTestCase {
    func testToDomain() throws {
        let thumbnailEntity = ThumbnailEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        let characterEntity = CharacterEntity(id: 1234, name: "dummy", thumbnail: thumbnailEntity)
        let characterResponseEntity = CharacterResponseEntity(results: [characterEntity], total: 1)
        let domainModel = try characterResponseEntity.toDomain()
        XCTAssertEqual(domainModel.total, 1)
    }
    
    func testToDomainWithNilResult() {
        let characterResponseEntity = CharacterResponseEntity(results: nil, total: 1)
        XCTAssertThrowsError(try characterResponseEntity.toDomain())
    }
    
    func testToDomainWithNilTotal() {
        let thumbnailEntity = ThumbnailEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        let characterEntity = CharacterEntity(id: 1234, name: "dummy", thumbnail: thumbnailEntity)
        let characterResponseEntity = CharacterResponseEntity(results: [characterEntity], total: nil)
        XCTAssertThrowsError(try characterResponseEntity.toDomain())
    }
}
