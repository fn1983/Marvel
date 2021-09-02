@testable import Marvel
import XCTest

class CharacterProviderTests: XCTestCase {
    var endpointCompletion = Provider<MarvelsService>.defaultEndpointMapping
    
    private func charactersProvider(_ response: SampleResponse? = nil, stubClosure: @escaping Provider<MarvelsService>
        .StubClosure = Provider.immediatelyStub) -> CharactersProviderProtocol {
        if let response = response {
            endpointCompletion = { (target: MarvelsService) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { response },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
        }
        return CharacterProvider(provider: Provider<MarvelsService>(endpointClosure: endpointCompletion, stubClosure: stubClosure))
    }

    func testMarvelCharactersProviderInit() {
        let provider = CharacterProvider()
        XCTAssertNotNil(provider)
    }

    func testCharactersListSuccess() {
        let success = expectation(description: "success")
        charactersProvider().getCharacterList(offset: "1") { (result) in
            if case let .success(marvelCharactersListResponse) = result {
                XCTAssertNotNil(marvelCharactersListResponse)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCharactersListTimeoutFailure() {
        let timeoutResponse = expectation(description: "timeoutResponse")
        charactersProvider(ProviderHelper.timedOutResponse).getCharacterList(offset: "1") { result in
            if case let .failure(useCaseError) = result,
               case let .generic(underlyingError) = useCaseError,
                           case let MoyaError.underlying(error, _) = underlyingError {
                            let netError = error as NSError
                            XCTAssertEqual(netError.domain, NSURLErrorDomain)
                            XCTAssertEqual(netError.code, URLError.timedOut.rawValue)
                            timeoutResponse.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCharactersListMappingError() {
        let parseError = expectation(description: "mappingError")
        charactersProvider(ProviderHelper.emptyResponse).getCharacterList(offset: "1234") { result in
            if case .failure = result {
                parseError.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCharactersDetailSuccess() {
        let success = expectation(description: "success")
        charactersProvider().getCharacterDetails(characterId: "1011334") { (result) in
            if case let .success(marvelCharactersDetailResponse) = result {
                XCTAssertNotNil(marvelCharactersDetailResponse)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCharactersDetailTimeoutFailure() {
        let timeoutResponse = expectation(description: "timeoutResponse")
        charactersProvider(ProviderHelper.timedOutResponse).getCharacterDetails(characterId: "1011334") { result in
            if case let .failure(timeOutError) = result,
               case let .generic(underlyingError) = timeOutError,
                case let MoyaError.underlying(error, _) = underlyingError {
                let netError = error as NSError
                XCTAssertEqual(netError.domain, NSURLErrorDomain)
                XCTAssertEqual(netError.code, URLError.timedOut.rawValue)
                timeoutResponse.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCharactersDetailMappingError() {
        let parseError = expectation(description: "mappingError")
        charactersProvider(ProviderHelper.emptyResponse).getCharacterDetails(characterId: "1011334") { result in
            if case .failure = result {
                parseError.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
