@testable import Marvel
import XCTest

class CharacterEntityTest: XCTestCase {

    func testToDomain() throws {
        let thumbnailEntity = ThumbnailEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        let characterEntity = CharacterEntity(id: 1234, name: "dummy", thumbnail: thumbnailEntity)
        let domainModel = try characterEntity.toDomain()
        XCTAssertEqual(characterEntity.name, domainModel.name)
    }
    
    func testToDomainWithNoId() {
        let thumbnailEntity = ThumbnailEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        let characterEntity = CharacterEntity(id: nil, name: "dummy", thumbnail: thumbnailEntity)
        XCTAssertThrowsError(try characterEntity.toDomain())
    }
    
    func testToDomainWithNoName() {
        let thumbnailEntity = ThumbnailEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        let characterEntity = CharacterEntity(id: 1234, name: nil, thumbnail: thumbnailEntity)
        XCTAssertThrowsError(try characterEntity.toDomain())
    }
    
    func testToDomainWithNoThumbnail() {
        let characterEntity = CharacterEntity(id: 1234, name: "dummy", thumbnail: nil)
        XCTAssertThrowsError(try characterEntity.toDomain())
    }
}
