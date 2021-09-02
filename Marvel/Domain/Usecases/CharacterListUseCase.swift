typealias CharacterListUseCaseCompletion = (Result<CharacterListModel, UseCaseError>) -> Void

protocol CharacterListUseCaseProtocol {
    func execute(with offset: Int, completion: @escaping CharacterListUseCaseCompletion)
}

final class CharacterListUseCase: CharacterListUseCaseProtocol {
    private let characterProvider: CharactersProviderProtocol!
    
    init(marvelsProvider: CharactersProviderProtocol) {
        self.characterProvider = marvelsProvider
    }

    func execute(with offset: Int, completion: @escaping CharacterListUseCaseCompletion) {
        characterProvider.getCharacterList(offset: "\(offset)", completion: { result in
            completion(result)
        })
    }
}
