@testable import Marvel
import Foundation

final class CharacterProviderMock: CharactersProviderProtocol {
    var result: Result<CharacterListModel, UseCaseError>?
    var characterDetailResult: Result<CharacterDetailModel, UseCaseError>?
    
    func getCharacterList(offset: String, completion: @escaping CharacterListCompletion) {
        guard let result = self.result else {
            fatalError("result not mock")
        }
        completion(result)
    }

    func getCharacterDetails(characterId: String, completion: @escaping CharacterDetailsCompletion) {
        guard let result = self.characterDetailResult else {
            fatalError("result not mock")
        }
        completion(result)
    }
}
