@testable import Marvel
import XCTest

class CharacterDetailsUseCaseTests: XCTestCase {
    var charactersDetailsUseCase: CharacterDetailsUseCase!
    var mockCharacterProvider = CharacterProviderMock()

    override func setUp() {
        super.setUp()
        charactersDetailsUseCase = CharacterDetailsUseCase(marvelsProvider: mockCharacterProvider)
    }

    func testGetMarvelCharactersListSuccess() {
        let success = expectation(description: "success")
        mockCharacterProvider.characterDetailResult = .success(CharacterDetailModel.dummyData())

        charactersDetailsUseCase.execute(with: 12345) { result in
            if case let .success(response) = result {
                XCTAssertNotNil(response)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersListFailure() {
        let serverError = expectation(description: "serverError")
        let underlyingError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        mockCharacterProvider.characterDetailResult = .failure(.generic(underlyingError))
        charactersDetailsUseCase.execute(with: 12345) { result in
            if case .failure = result {
                serverError.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
