import Foundation

struct CharacterCellViewModel: CellViewModel {
    let name: String
    let thumbnailURL: URL?

    init(name: String, thumbnailURL: URL?) {
        self.name = name
        self.thumbnailURL = thumbnailURL
    }
}
