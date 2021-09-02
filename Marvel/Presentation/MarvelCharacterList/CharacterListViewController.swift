import Kingfisher
import UIKit

protocol CharacterListView: ViewProtocol {
    var presenter: CharacterListPresenterProtocol! { get set }
    func changeViewState(viewState: CharacterListViewState)
}

class CharacterListViewController: BaseViewController, CharacterListView {
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var errorView: UIView!
    @IBOutlet weak private var characterListTableView: UITableView!
    var presenter: CharacterListPresenterProtocol!
    static var storyboardName: String { "CharacterList" }
    private var cellIdentifier: String {
        return "CharacterCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Character List"
        characterListTableView.prefetchDataSource = self
        characterListTableView.register(UINib.init(nibName: "CharacterCell", bundle: Bundle.main),
                                        forCellReuseIdentifier: cellIdentifier)
        characterListTableView.tableFooterView = UIView()
        hideError()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    @IBAction private func didTapOnRetry(_ sender: Any) {
        presenter.didTapOnRetry()
    }
    
    private func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        hideError()
    }
    
    private func hideLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

    private func updateList() {
        hideLoader()
        hideError()
        characterListTableView.reloadData()
    }
    
    private func hideError() {
        errorView.isHidden = true
    }
    
    func changeViewState(viewState: CharacterListViewState) {
        switch viewState {
        case .loading:
            showLoader()
        case .error:
            errorView.isHidden = false
        case .render:
            updateList()
        case .clear:
            break
        case let .renderNextPage(indexPaths):
            reloadNewIndexPaths(with: indexPaths)
        }
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.totalElementOnServer()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CharacterCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CharacterCell
        if cell == nil {
            cell = CharacterCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        if !isLoadingCell(for: indexPath) {
            guard let cellViewModel = presenter.viewModelForCell(at: indexPath) as? CharacterCellViewModel else {
                return cell ?? UITableViewCell()
            }
            cell?.setup(viewModel: cellViewModel)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectCharacter(at: indexPath)
    }
}

extension CharacterListViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter.fetchNextPage()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= presenter.numberOfRowsInSection(section: 0)
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = characterListTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    func reloadNewIndexPaths(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        hideLoader()
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            return
        }
        // 2
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        self.characterListTableView.reloadRows(at: Array(indexPathsToReload), with: .fade)
    }
}
