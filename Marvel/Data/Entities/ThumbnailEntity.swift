struct ThumbnailEntity: Codable {
    let path: String?
    let fileExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
