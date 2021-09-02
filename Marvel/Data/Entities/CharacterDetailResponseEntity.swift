import Foundation

struct CharacterDetailResponseEntity: Codable {
    let copyright: String?
    let data: CharacterDataEntity?

    func toDomain() throws -> CharacterDetailModel {
        guard let characterDetail = data?.results?[0],
              let name = characterDetail.name,
              let copyright = copyright else {
            let error = EncodingError.Context(codingPath: [CharacterDetailResponseEntity.CodingKeys.data],
                                              debugDescription: "invalid data")
            throw EncodingError.invalidValue(self, error)
        }
        guard let thumbnailPath = characterDetail.thumbnail?.path else {
            let error = EncodingError.Context(codingPath: [CharacterDetailResponseEntity.CodingKeys.data],
                                              debugDescription: "invalid thumbnail path")
            throw EncodingError.invalidValue(self, error)
        }
        guard let fileExtension = characterDetail.thumbnail?.fileExtension,
            let thumbnailURL = URL(string: thumbnailPath + "." + fileExtension) else {
            let error = EncodingError.Context(codingPath: [CharacterDetailResponseEntity.CodingKeys.data],
                                              debugDescription: "invalid fileExtension")
            throw EncodingError.invalidValue(self, error)
        }
        return CharacterDetailModel(name: name, copyright: copyright, thumbnailURL: thumbnailURL)
    }
}
