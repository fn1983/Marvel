import Foundation

protocol CharacterDetailsPresenterProtocol: BasePresenterProtocol, TableViewDataSource {
    func add(dependency: CharacterDetailsPresenterDependency)
    func didTapOnRetry()
}

struct CharacterDetailsPresenterDependency {
    let view: CharacterDetailsView
    let characterDetailsUseCase: CharacterDetailsUseCaseProtocol
    let characterId: Int
}

enum CharacterDetailsViewState: Equatable {
    case clear
    case loading
    case render(CharacterDetailsViewModel)
    case error
}

class CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    weak var view: CharacterDetailsView?
    private var characterDetailsUseCase: CharacterDetailsUseCaseProtocol!
    private var characterId: Int!
    var viewState: CharacterDetailsViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.changeViewState(viewState: viewState)
        }
    }
    func viewDidAppear() {
        fetchCharacterDetails()
    }
    
    private func fetchCharacterDetails() {
        viewState = .loading
        characterDetailsUseCase.execute(with: characterId) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(model):
                let viewModel = CharacterDetailsViewModel(name: model.name,
                                                          copyrightLabel: model.copyright,
                                                          imageUrl: model.thumbnailURL)
                self.viewState = .render(viewModel)
            case .failure:
                self.viewState = .error
            }
        }
    }

    func add(dependency: CharacterDetailsPresenterDependency) {
        self.characterId = dependency.characterId
        self.view = dependency.view
        self.characterDetailsUseCase = dependency.characterDetailsUseCase
    }
    
    func didTapOnRetry() {
        fetchCharacterDetails()
    }
}

