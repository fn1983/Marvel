import Foundation

struct CharacterEntity: Codable {
    let id: Int?
    let name: String?
    let thumbnail: ThumbnailEntity?

    func toDomain() throws -> CharacterModel {
        guard let id = id else {
            let error = EncodingError.Context(codingPath: [CharacterEntity.CodingKeys.thumbnail],
                                              debugDescription: "invalid id")
            throw EncodingError.invalidValue(self, error)
        }
        guard let name = name else {
            let error = EncodingError.Context(codingPath: [CharacterEntity.CodingKeys.name],
                                              debugDescription: "invalid name")
            throw EncodingError.invalidValue(self, error)
        }
        guard let thumbnailPath = thumbnail?.path else {
            let error = EncodingError.Context(codingPath: [CharacterEntity.CodingKeys.thumbnail],
                                              debugDescription: "invalid thumbnail path")
            throw EncodingError.invalidValue(self, error)
        }
        guard let fileExtension = thumbnail?.fileExtension,
            let thumbnailURL = URL(string: thumbnailPath + "." + fileExtension) else {
            let error = EncodingError.Context(codingPath: [CharacterEntity.CodingKeys.thumbnail],
                                              debugDescription: "invalid fileExtension")
            throw EncodingError.invalidValue(self, error)
        }
        
        return CharacterModel(id: id, name: name, thumbnailURL: thumbnailURL)
    }
}
