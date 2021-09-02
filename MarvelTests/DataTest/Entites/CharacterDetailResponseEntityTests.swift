@testable import Marvel
import XCTest

class CharacterDetailResponseEntityTests: XCTestCase {
    func testToDomain() throws {
        let thumbnailEntity = ThumbnailEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        let characterDetailEntity = CharacterDetailEntity(name: "dummy", thumbnail: thumbnailEntity)
        let characterDataEntity = CharacterDataEntity(results: [characterDetailEntity])
        let characterDetailResponseEntity = CharacterDetailResponseEntity(copyright: "mockCopyright", data: characterDataEntity)
        let domainModel = try characterDetailResponseEntity.toDomain()
        XCTAssertEqual(domainModel.name, characterDetailResponseEntity.data?.results?[0].name)
    }
    
    func testToDomainWithNilData() {
        let characterDetailResponseEntity = CharacterDetailResponseEntity(copyright: "mockCopyright", data: nil)
        XCTAssertThrowsError(try characterDetailResponseEntity.toDomain())
    }
    
    func testToDomainWithNilCopyright() {
        let thumbnailEntity = ThumbnailEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg")
        let characterDetailEntity = CharacterDetailEntity(name: "dummy", thumbnail: thumbnailEntity)
        let characterDataEntity = CharacterDataEntity(results: [characterDetailEntity])
        let characterDetailResponseEntity = CharacterDetailResponseEntity(copyright: nil, data: characterDataEntity)
        XCTAssertThrowsError(try characterDetailResponseEntity.toDomain())
    }
}
