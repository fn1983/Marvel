import Foundation
@testable import Marvel

final class CharacterListUseCaseMock: CharacterListUseCaseProtocol {
    var result: Result<CharacterListModel, UseCaseError>?
    func execute(with offset: Int, completion: @escaping CharacterListUseCaseCompletion) {
        guard let result = self.result else {
            fatalError("result not mock")
        }
        completion(result)
    }
}
