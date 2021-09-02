typealias CharacterDetailsUseCaseCompletion = (Result<CharacterDetailModel, UseCaseError>) -> Void

protocol CharacterDetailsUseCaseProtocol {
    func execute(with characterId: Int, completion: @escaping CharacterDetailsUseCaseCompletion)
}

final class CharacterDetailsUseCase: CharacterDetailsUseCaseProtocol {
    private let characterProvider: CharactersProviderProtocol!
    
    init(marvelsProvider: CharactersProviderProtocol) {
        self.characterProvider = marvelsProvider
    }

    func execute(with characterId: Int, completion: @escaping CharacterDetailsUseCaseCompletion) {
        characterProvider.getCharacterDetails(characterId: "\(characterId)", completion: { result in
            completion(result)
        })
    }
}
