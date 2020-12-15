//
//  RepositoriesViewController.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit


protocol RepositoriesDisplayLogic: class {
    func showError(message: String)
    func showRepositories(viewModel: Repositories.FetchRepositories.ViewModel)
}

class RepositoriesViewController: UITableViewController {
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }

    // MARK: Fetch Repositories
    private var displayedRepositories = [Repositories.FetchRepositories.ViewModel.DisplayedRepository]()
    private var page = 1
    private var query = ""
    private var isLoading = false

    @objc private func fetchRepositories(_ searchBar: UISearchBar) {
        displayedRepositories = []
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            tableView.reloadData()
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

   // MARK: UITableViewDataSource && UITableViewDelegate
    private func registerTableViewCell() {
        let cell = UINib(nibName: repositoryCellIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: repositoryCellIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedRepositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellIdentifier, for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell() }
        let displayedRepository = displayedRepositories[indexPath.row]
        cell.setup(viewModel: displayedRepository)
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == displayedRepositories.count - 1  {
            fetchMoreRepositories()
        }
    }
}

// MARK: RepositoriesDisplayLogic
extension RepositoriesViewController: RepositoriesDisplayLogic {
    func showError(message: String) {
        // Show error alert
    }

    func showRepositories(viewModel: Repositories.FetchRepositories.ViewModel) {
        
        displayedRepositories.append(contentsOf: viewModel.displayedRepositories)
        
        tableView.reloadData()
    }
}

// MARK: UISearchBarDelegate
extension RepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.fetchRepositories(_:)), object: searchBar)
        perform(#selector(self.fetchRepositories(_:)), with: searchBar, afterDelay: 0.40)
    }
}
