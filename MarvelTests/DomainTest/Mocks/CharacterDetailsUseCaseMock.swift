import Foundation
@testable import Marvel

final class CharacterDetailsUseCaseMock: CharacterDetailsUseCaseProtocol {
    var result: Result<CharacterDetailModel, UseCaseError>?
    func execute(with characterId: Int, completion: @escaping CharacterDetailsUseCaseCompletion) {
        guard let result = self.result else {
            fatalError("result not mock")
        }
        completion(result)
    }
}
