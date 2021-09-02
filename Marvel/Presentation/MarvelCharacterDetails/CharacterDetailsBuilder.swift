import Foundation

class CharacterDetailsBuilder {
    var presenter: CharacterDetailsPresenterProtocol!
    var view: CharacterDetailsView!

    func build(characterId: Int) -> CharacterDetailsView {
        presenter = DependencyManager.characterDetailsPresenter()
        view = DependencyManager.characterDetailsView()
        view.presenter = presenter
        let marvelDetailsUseCase = DependencyManager.characterDetailsUseCase(characterProvider: DependencyManager.characterProvider())
        let dependency = CharacterDetailsPresenterDependency(view: view,
                                                             characterDetailsUseCase: marvelDetailsUseCase,
                                                             characterId: characterId)
        presenter.add(dependency: dependency)
        return view
    }
}
