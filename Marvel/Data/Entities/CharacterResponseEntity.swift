import Foundation

struct CharacterResponseEntity: Codable {
    let results: [CharacterEntity]?
    let total: Int?
    
    func toDomain() throws -> CharacterListModel {
        guard let characterModels = try results?.map({ try $0.toDomain() }), let total = total else {
            let error = EncodingError.Context(codingPath: [CharacterResponseEntity.CodingKeys.results],
                                                 debugDescription: "invalid character list")
            throw EncodingError.invalidValue(self, error)
        }
        return CharacterListModel(total: total, characters: characterModels)
    }
}

struct CharacterDataEntity: Codable {
    let results: [CharacterDetailEntity]?
}

struct CharacterDetailEntity: Codable {
    let name: String?
    let thumbnail: ThumbnailEntity?
}
