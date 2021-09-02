import Foundation
@testable import Marvel

final class CharacterListViewMock: CharacterListView {
    var viewState: CharacterListViewState = .clear
    func changeViewState(viewState: CharacterListViewState) {
        self.viewState = viewState
    }
    
    var presenter: CharacterListPresenterProtocol!
}
