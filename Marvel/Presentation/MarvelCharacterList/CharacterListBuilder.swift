import Foundation

class CharacterListBuilder {
    var presenter: CharacterListPresenterProtocol!
    var view: CharacterListView!
    func build() -> CharacterListView {
        presenter = DependencyManager.characterListPresenter()
        view = DependencyManager.characterListView()
        view.presenter = presenter
        let characterListUseCase = DependencyManager.characterListUseCase(characterProvider: DependencyManager.characterProvider())
        let dependency = CharacterListPresenterDependency(view: view, characterListUseCase: characterListUseCase)
        presenter.add(dependency: dependency)
        return view
    }
}
