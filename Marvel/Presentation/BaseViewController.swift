import Foundation
import UIKit

protocol ViewProtocol: BaseStoryboard {
}

extension ViewProtocol {
    static var storyboardName: String { "" }
}

class BaseViewController: UIViewController {
}
