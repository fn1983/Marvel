import Foundation

struct CharacterDetailsViewModel: Equatable {
    let name: String
    let copyrightText: String
    let imageUrl: URL?

    init(name: String, copyrightLabel: String, imageUrl: URL?) {
        self.name = name
        self.copyrightText = copyrightLabel
        self.imageUrl = imageUrl
    }
}
