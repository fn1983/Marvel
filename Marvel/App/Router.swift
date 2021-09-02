import Foundation
import UIKit

enum Screen {
    case charactersList
    case characterDetails(characterId: Int)
}

class Router {
    private init() { }
    static let shared: Router = Router()
    
    func navigate(to screen: Screen, fromScreen: ViewProtocol) {
        switch screen {
        case .charactersList:
            guard let fromViewController = fromScreen as? UIViewController else {
                assertionFailure("Main View controller not found")
                return
            }
            guard let viewController = CharacterListBuilder().build() as? BaseViewController else {
                return
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            fromViewController.showDetailViewController(navigationController, sender: nil)
        case let .characterDetails(characterId):
            let navigationController = (fromScreen as? UIViewController)?.navigationController
            guard let viewController = CharacterDetailsBuilder().build(characterId: characterId) as? BaseViewController else {
                return
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
