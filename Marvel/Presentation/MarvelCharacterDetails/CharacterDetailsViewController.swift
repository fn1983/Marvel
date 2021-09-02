import Kingfisher
import UIKit

protocol CharacterDetailsView: ViewProtocol {
    var presenter: CharacterDetailsPresenterProtocol! { get set }
    func changeViewState(viewState: CharacterDetailsViewState)
}

class CharacterDetailsViewController: BaseViewController, CharacterDetailsView {
    var presenter: CharacterDetailsPresenterProtocol!
    static var storyboardName: String { "CharacterDetails" }
    
    @IBOutlet private weak var detailContainerView: UIView!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterName: UILabel!
    @IBOutlet private weak var copyrightLabel: UILabel!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Character Details"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    private func render(viewModel: CharacterDetailsViewModel) {
        hideLoader()
        errorView.isHidden = true
        detailContainerView.isHidden = false
        characterName.text = viewModel.name
        copyrightLabel.text = viewModel.copyrightText
        characterImageView.kf.setImage(with: viewModel.imageUrl)
    }
    
    private func showLoader() {
        loaderView.isHidden = false
        errorView.isHidden = true
    }
    
    private func hideLoader() {
        loaderView.isHidden = true
    }
    
    private func showError() {
        hideLoader()
        errorView.isHidden = false
    }
    
    @IBAction func didTapOnRetryButton(_ sender: UIButton) {
        presenter.didTapOnRetry()
    }
    
    func changeViewState(viewState: CharacterDetailsViewState) {
        switch viewState {
        case .loading:
            showLoader()
        case let .render(viewModel):
            render(viewModel: viewModel)
        case .error:
            showError()
        case .clear:
            break
        }
    }
}
