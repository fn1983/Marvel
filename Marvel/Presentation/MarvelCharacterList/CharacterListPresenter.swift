import Foundation

protocol CharacterListPresenterProtocol: BasePresenterProtocol, TableViewDataSource {
    func add(dependency: CharacterListPresenterDependency)
    func didTapOnRetry()
    func didSelectCharacter(at indexPath: IndexPath)
    func fetchNextPage()
    func totalElementOnServer() -> Int
}

struct CharacterListPresenterDependency {
    let view: CharacterListView
    let characterListUseCase: CharacterListUseCaseProtocol
}

enum CharacterListViewState: Equatable {
    case loading
    case render
    case renderNextPage([IndexPath]?)
    case error
    case clear
}

class CharacterListPresenter: CharacterListPresenterProtocol {
    weak var view: CharacterListView?
    private var characterListUseCase: CharacterListUseCaseProtocol!
    private var characterList: [CharacterModel] = []
    private var totalCharacterOnServer = 0
    var viewState: CharacterListViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.changeViewState(viewState: viewState)
        }
    }
    var isFetchingNextPage = false

    func viewDidAppear() {
        fetchCharacterList()
    }
    
    private func fetchCharacterList() {
        if characterList.isEmpty {
            viewState = .loading
        }
        characterListUseCase.execute(with: characterList.count) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(characterListModel):
                let models = characterListModel.characters
                self.totalCharacterOnServer = characterListModel.total
                self.isFetchingNextPage = false
                self.characterList += models
                guard self.characterList.count > models.count else {
                    self.viewState = .render
                    return
                }
                let indexPathsToReload = self.calculateIndexPathsToReload(from: models)
                self.viewState = .renderNextPage(indexPathsToReload)
            case .failure:
                self.viewState = .error
            }
        }
    }
    
    func didTapOnRetry() {
        fetchCharacterList()
    }

    func add(dependency: CharacterListPresenterDependency) {
        self.view = dependency.view
        self.characterListUseCase = dependency.characterListUseCase
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return characterList.count
    }

    func viewModelForCell(at indexPath: IndexPath) -> CellViewModel? {
        let marvelModel = characterList[indexPath.row]
        return CharacterCellViewModel(name: marvelModel.name, thumbnailURL: marvelModel.thumbnailURL)
    }
    
    func didSelectCharacter(at indexPath: IndexPath) {
        let marvelId = characterList[indexPath.row].id
        guard let view = view else {
            return
        }
        Router.shared.navigate(to: .characterDetails(characterId: marvelId), fromScreen: view)
    }
    
    private func calculateIndexPathsToReload(from newModerators: [CharacterModel]) -> [IndexPath] {
      let startIndex = characterList.count - newModerators.count
      let endIndex = startIndex + newModerators.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func totalElementOnServer() -> Int {
        return totalCharacterOnServer
    }
    
    func fetchNextPage() {
        if !isFetchingNextPage {
            isFetchingNextPage = true
            fetchCharacterList()
        }
    }
}

