import Foundation

struct DependencyManager {
    static func characterListUseCase(characterProvider: CharactersProviderProtocol) -> CharacterListUseCaseProtocol {
        return CharacterListUseCase(marvelsProvider: characterProvider)
    }
    static func characterProvider() -> CharactersProviderProtocol {
        return CharacterProvider()
    }
    static func characterListPresenter() -> CharacterListPresenterProtocol {
        return CharacterListPresenter()
    }
    static func characterListView() -> CharacterListView {
        return CharacterListViewController.instantiate()
    }
    static func characterDetailsPresenter() -> CharacterDetailsPresenterProtocol {
        return CharacterDetailsPresenter()
    }
    static func characterDetailsView() -> CharacterDetailsView {
        return CharacterDetailsViewController.instantiate()
    }
    static func characterDetailsUseCase(characterProvider: CharactersProviderProtocol) -> CharacterDetailsUseCaseProtocol {
        return CharacterDetailsUseCase(marvelsProvider: characterProvider)
    }
}
