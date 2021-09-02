import Foundation

enum MarvelsService {
    case characterList(offset: String)
    case characterDetails(id: String)
}

struct Constants {
    static let keys = "apikey"
    static let timeStampKey = "ts"
    static let timeStamp = "1"
    static let hash = "hash"
    static let publicKey = "40ef2a7d81972b414f33ee6e1758d496"
    static let md5Hash = "792c7f23c71bd306132911065eb01ed6"
    static let limitKey = "limit"
    static let limit = "15"
    static let offsetKey = "offset"
}

extension MarvelsService: TargetType {
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com" + servicePath)!
    }
    
    var servicePath: String {
        "/v1/public"
    }
    
    var path: String {
        switch self {
        case .characterList:
            return "/characters"
        case let .characterDetails(id):
            return "/characters/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .characterList, .characterDetails:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .characterList(offset):
            let params = [Constants.limitKey: Constants.limit, Constants.offsetKey: offset,
                          Constants.keys: Constants.publicKey, Constants.timeStampKey: Constants.timeStamp,
                          Constants.hash: Constants.md5Hash]
            return .requestParameters(parameters: params, encoding: encoding)
        case .characterDetails:
            let params = [Constants.keys: Constants.publicKey, Constants.timeStampKey: Constants.timeStamp,
                          Constants.hash: Constants.md5Hash]
            return .requestParameters(parameters: params, encoding: encoding)
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        guard let url = Bundle.main.url(forResource: mockResource, withExtension: mockResourceExtension),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var mockResource: String {
        switch self {
        case .characterList:
            return "CharacterList"
        case .characterDetails:
            return "CharacterDetails"
        }
    }
    
    var mockResourceExtension: String {
        return "json"
    }
}
