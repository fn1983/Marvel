import Foundation
@testable import Marvel

final class CharacterDetailsViewMock: CharacterDetailsView {
    var presenter: CharacterDetailsPresenterProtocol!
    var viewState: CharacterDetailsViewState = .clear
    func changeViewState(viewState: CharacterDetailsViewState) {
        self.viewState = viewState
    }
}
