import Foundation

struct CharacterModel: Equatable {
    let id: Int
    let name: String
    let thumbnailURL: URL?
    
    init(id: Int, name: String, thumbnailURL: URL?) {
        self.id = id
        self.name = name
        self.thumbnailURL = thumbnailURL
    }
}

struct CharacterListModel {
    let total: Int
    let characters: [CharacterModel]
}
