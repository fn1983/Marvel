import UIKit

class MainViewController: BaseViewController, ViewProtocol {

    static var storyboardName: String { "Main" }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Router.shared.navigate(to: .charactersList, fromScreen: self)
    }
}
