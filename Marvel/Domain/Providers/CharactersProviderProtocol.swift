protocol CharactersProviderProtocol {
    typealias CharacterListCompletion = (Result<CharacterListModel, UseCaseError>) -> Void
    typealias CharacterDetailsCompletion = (Result<CharacterDetailModel, UseCaseError>) -> Void
    
    func getCharacterList(offset: String, completion: @escaping CharacterListCompletion)
    func getCharacterDetails(characterId: String, completion: @escaping CharacterDetailsCompletion)
}
