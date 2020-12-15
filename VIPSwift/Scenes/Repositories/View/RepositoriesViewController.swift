//
//  RepositoriesViewController.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit
import Lottie

protocol RepositoriesDisplayLogic: class {
    func showError(message: String)
    func showRepositories(viewModel: Repositories.FetchRepositories.ViewModel)
}

class RepositoriesViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var repositoriesTableView: UITableView!

    // MARK: Properties
    var interactor: RepositoriesBusinessLogic?
    private let repositoryCellIdentifier = "RepositoryTableViewCell"

    // MARK: Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = RepositoriesInteractor()
        let presenter = RepositoriesPresenter()
        let router = RepositoriesRouter()

        viewController.interactor = interactor
        //        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        setupLottie()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }

    // MARK: Lottie Configuration
    private func setupLottie() {
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.animationSpeed = 0.5
        lottieView.play()
    }

    private func initialPlaceholder() {
        placeholderView.isHidden = false
        placeholderLabel.text = "Search a keyword above and find the best repositories!"
        lottieView.play()
    }

    private func errorPlaceholder() {
        placeholderView.isHidden = false
        placeholderLabel.text = "Ohhh! We could not find any results for this query"
        lottieView.play()
    }

    private func hidePlaceholder() {
        placeholderView.isHidden = true
        lottieView.stop()
    }

    // MARK: Fetch Repositories
    private var displayedRepositories = [Repositories.FetchRepositories.ViewModel.DisplayedRepository]()
    private var page = 1
    private var query = ""
    private var isLoading = false

    @objc private func fetchRepositories(_ searchBar: UISearchBar) {
        displayedRepositories = []
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            initialPlaceholder()
            repositoriesTableView.reloadData()
            return
        }
        self.query = query
        self.page = 1
        let request = Repositories.FetchRepositories.Request(query: query, page: page)
        interactor?.searchRepositories(request: request)
    }

    private func fetchMoreRepositories() {
        self.page += 1
        let request = Repositories.FetchRepositories.Request(query: query, page: page)
        interactor?.searchRepositories(request: request)
    }

    // MARK: Setup Table View
    private func registerTableViewCell() {
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        let cell = UINib(nibName: repositoryCellIdentifier, bundle: nil)
        repositoriesTableView.register(cell, forCellReuseIdentifier: repositoryCellIdentifier)
    }
}

// MARK: UITableViewDataSource && UITableViewDelegate
extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellIdentifier, for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell() }
        let displayedRepository = displayedRepositories[indexPath.row]
        cell.setup(viewModel: displayedRepository)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == displayedRepositories.count - 1  {
            fetchMoreRepositories()
        }
    }
}

// MARK: RepositoriesDisplayLogic
extension RepositoriesViewController: RepositoriesDisplayLogic {
    func showError(message: String) {
       errorPlaceholder()
    }

    func showRepositories(viewModel: Repositories.FetchRepositories.ViewModel) {
        hidePlaceholder()

        displayedRepositories.append(contentsOf: viewModel.displayedRepositories)
        repositoriesTableView.reloadData()
    }
}

// MARK: UISearchBarDelegate
extension RepositoriesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        initialPlaceholder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.fetchRepositories(_:)), object: searchBar)
        perform(#selector(self.fetchRepositories(_:)), with: searchBar, afterDelay: 0.40)
    }
}
