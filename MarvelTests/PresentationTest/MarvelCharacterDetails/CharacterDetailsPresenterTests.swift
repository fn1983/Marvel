@testable import Marvel
import XCTest

class CharacterDetailsPresenterTests: XCTestCase {
    var presenter: CharacterDetailsPresenter!
    var characterDetailsUseCaseMock: CharacterDetailsUseCaseMock!
    var mockView: CharacterDetailsViewMock!

    override func setUp() {
        super.setUp()
        presenter = CharacterDetailsPresenter()
        mockView = CharacterDetailsViewMock()
        mockView.presenter = presenter
        characterDetailsUseCaseMock = CharacterDetailsUseCaseMock()
        let dependency = CharacterDetailsPresenterDependency(view: mockView,
                                                             characterDetailsUseCase: characterDetailsUseCaseMock,
                                                             characterId: 111232)
        presenter.add(dependency: dependency)
    }
    
    func testViewDidAppear() {
        let model = CharacterDetailModel.dummyData()
        characterDetailsUseCaseMock.result = .success(model)
        presenter.viewDidAppear()
        let viewModel = CharacterDetailsViewModel(name: model.name, copyrightLabel: model.copyright, imageUrl: model.thumbnailURL)
        XCTAssertEqual(.render(viewModel), mockView.viewState, "expected success execution of useCase")
    }
    
    func testAPIError() {
        let underlyingError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        characterDetailsUseCaseMock.result = .failure(.marvelApi(.error400(underlyingError)))
        presenter.viewDidAppear()
        XCTAssertEqual(mockView.viewState, .error, "expected failure execution of useCase")
    }
    
    func testDidTapOnRetry() {
        //Given
        let model = CharacterDetailModel.dummyData()
        characterDetailsUseCaseMock.result = .success(model)
        let viewModel = CharacterDetailsViewModel(name: model.name, copyrightLabel: model.copyright, imageUrl: model.thumbnailURL)

        //When
        presenter.didTapOnRetry()

        //Then
        XCTAssertEqual(.render(viewModel), mockView.viewState, "expected success execution of useCase")
    }
}

extension CharacterDetailModel {
    static func dummyData() -> CharacterDetailModel{
        return CharacterDetailModel(name: "3-D Man", copyright: "© 2021 MARVEL",
                                    thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
    }
}
