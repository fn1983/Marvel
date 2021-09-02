@testable import Marvel
import XCTest

class CharacterListUseCaseTests: XCTestCase {
    var charactersListUseCase: CharacterListUseCase!
    var mockCharacterProvider = CharacterProviderMock()

    override func setUp() {
        super.setUp()
        charactersListUseCase = CharacterListUseCase(marvelsProvider: mockCharacterProvider)
    }

    func testGetMarvelCharactersListSuccess() {
        let success = expectation(description: "success")
        mockCharacterProvider.result = .success(CharacterListModel.dummyData())

        charactersListUseCase.execute(with: 12345) { result in
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
        mockCharacterProvider.result = .failure(.generic(underlyingError))
        charactersListUseCase.execute(with: 12345) { result in
            if case .failure = result {
                serverError.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
