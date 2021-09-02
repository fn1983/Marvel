import Foundation

struct CharacterDetailModel {
    let name: String
    let copyright: String
    let thumbnailURL: URL?
    
    init(name: String, copyright: String, thumbnailURL: URL?) {
        self.name = name
        self.copyright = copyright
        self.thumbnailURL = thumbnailURL
    }
    
}
