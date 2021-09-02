import Foundation

class CharacterProvider: CharactersProviderProtocol {
    private let provider: Provider<MarvelsService>

    convenience init() {
        self.init(provider: Provider<MarvelsService>())
    }

    init(provider: Provider<MarvelsService>) {
        self.provider = provider
    }

    func getCharacterList(offset: String, completion: @escaping CharacterListCompletion) {
        provider.request(.characterList(offset: offset)) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(CharacterResponseEntity.self, atKeyPath: "data")
                    let characterResponseModel = try response.toDomain()
                    completion(.success(characterResponseModel))
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case let .failure(error):
                if case let .underlying(_, response) = error, response?.statusCode == 400 {
                    completion(.failure(.marvelApi(.error400(error))))
                } else if case let .underlying(_, response) = error, response?.statusCode == 500 {
                    completion(.failure(.marvelApi(.error500(error))))
                } else {
                    completion(.failure(.generic(error)))
                }
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).
            }
        }
    }
    
    func getCharacterDetails(characterId: String, completion: @escaping CharacterDetailsCompletion) {
        provider.request(.characterDetails(id: characterId)) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(CharacterDetailResponseEntity.self)
                    let detailsModels = try response.toDomain()
                    completion(.success(detailsModels))
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case let .failure(error):
                if case let .underlying(_, response) = error, response?.statusCode == 400 {
                    completion(.failure(.marvelApi(.error400(error))))
                } else if case let .underlying(_, response) = error, response?.statusCode == 500 {
                    completion(.failure(.marvelApi(.error500(error))))
                } else {
                    completion(.failure(.generic(error)))
                }
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).
            }
        }
    }
}
