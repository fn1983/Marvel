@testable import Marvel
import XCTest

class CharacterListPresenterTests: XCTestCase {
    var presenter: CharacterListPresenter!
    var characterListUseCaseMock: CharacterListUseCaseMock!
    var mockView: CharacterListViewMock!

    override func setUp() {
        super.setUp()
        presenter = CharacterListPresenter()
        mockView = CharacterListViewMock()
        mockView.presenter = presenter
        characterListUseCaseMock = CharacterListUseCaseMock()
        let dependency = CharacterListPresenterDependency(view: mockView, characterListUseCase: characterListUseCaseMock)
        presenter.add(dependency: dependency)
    }
    
    func testViewDidAppear() {
        characterListUseCaseMock.result = .success(CharacterListModel.dummyData())
        presenter.viewDidAppear()
        XCTAssertEqual(mockView.viewState, .render,"expected success execution of usecase")
    }
    
    func testAPIError() {
        let underlyingError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        characterListUseCaseMock.result = .failure(.marvelApi(.error400(underlyingError)))
        presenter.viewDidAppear()
        XCTAssertEqual(mockView.viewState, .error, "expected failure execution of usecase")
    }
    
    func testDidTapOnRetry() {
        //Given
        characterListUseCaseMock.result = .success(CharacterListModel.dummyData())

        //When
        presenter.didTapOnRetry()

        //Then
        XCTAssertEqual(mockView.viewState, .render, "expected success execution of usecase")
    }

    func testNumberOfRowsForTableView() {
        //Given
        characterListUseCaseMock.result = .success(CharacterListModel.dummyData())
        presenter.viewDidAppear()
        //When
        let result = presenter.numberOfRowsInSection(section: 0)

        //Then
        XCTAssertEqual(result, 1)
    }

    func testTotalElementOnServer() {
        //Given
        characterListUseCaseMock.result = .success(CharacterListModel.dummyData())
        presenter.viewDidAppear()
        //When
        let result = presenter.totalElementOnServer()

        //Then
        XCTAssertEqual(result, 1)
    }
    
    func testFetchNextPage() {
        //Given
        characterListUseCaseMock.result = .success(CharacterListModel.dummyData())
        presenter.viewDidAppear()
        //When
        presenter.fetchNextPage()
        //Then
        guard case let .renderNextPage(indexPaths) = mockView.viewState else {
            return XCTFail("expected indexPaths")
        }
        XCTAssertEqual(indexPaths?.count, 1)
    }
    
    func testViewModelOfRowsForTableView() throws {
        //Given
        characterListUseCaseMock.result = .success(CharacterListModel.dummyData())
        presenter.viewDidAppear()
        //When
        let result = presenter.viewModelForCell(at: IndexPath(row: 0, section: 0))

        //Then
        let viewModel = try XCTUnwrap(result as? CharacterCellViewModel)
        XCTAssertEqual(viewModel.name, CharacterModel.dummyData().name)
    }
}

extension CharacterListModel {
    static func dummyData() -> CharacterListModel {
        return CharacterListModel(total: 1, characters: [CharacterModel.dummyData()])
    }
}
extension CharacterModel {
    static func dummyData() -> CharacterModel{
        return CharacterModel(id: 1011334,
                              name: "3-D Man",
                              thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
    }
}
