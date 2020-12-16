//
//  RepositoriesViewControllerTests.swift
//  VIPSwiftTests
//
//  Created by Vinicius Salmont on 15/12/20.
//

@testable import VIPSwift
import XCTest

class RepositoriesViewControllerTests: XCTestCase {

    // MARK: - Subject under test
    var sut: RepositoriesViewController!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        setupRepositoriesViewController()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Setup
    func setupRepositoriesViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(identifier: "RepositoriesViewController") as? RepositoriesViewController
        _ = sut.view
    }

    // MARK: - Spys
    class RepositoriesBusinessLogicSpy: RepositoriesBusinessLogic {
        var repositories: [RepositoryModel]?

        var searchRepositoriesCalled = false

        func searchRepositories(request: Repositories.FetchRepositories.Request) {
            searchRepositoriesCalled = true
        }
    }

    class TableViewSpy: UITableView {
        var reloadDataCalled = false

        override func reloadData() {
            reloadDataCalled = true
        }
    }

    // MARK: - Tests

    func testShouldDisplayRepositories() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.repositoriesTableView = tableViewSpy
        _ = sut.view

        let displayedRepositories = [Repositories.FetchRepositories.ViewModel.DisplayedRepository(id: 0, fullName: "repository", description: "description", language: "swift", stars: 10, watchers: 50, login: "vinsalmont", avatarURL: "https://www.google.com")]
        let viewModel = Repositories.FetchRepositories.ViewModel(displayedRepositories: displayedRepositories)

        // When
        sut.showRepositories(viewModel: viewModel)

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Failed")

    }

    func testShouldFetchRepositoriesByQuery() {
        // Given
        let repositoriesBusinessLogicSpy = RepositoriesBusinessLogicSpy()
        sut.interactor = repositoriesBusinessLogicSpy
        _ = sut.view

        // When
        sut.navigationItem.searchController?.searchBar.text = "swift"
        sut.searchBar(sut.navigationItem.searchController!.searchBar, textDidChange: "swift")

        // Then
//        wait(for: [expectation(description: "Waiting")], timeout: 10)
        XCTAssert(repositoriesBusinessLogicSpy.searchRepositoriesCalled, "It should search the repositories")
    }

    func testShouldPopulateTheTableViewCorrectly() {
        // Given
        let tableView = sut.repositoriesTableView

        let displayedRepositories = [Repositories.FetchRepositories.ViewModel.DisplayedRepository(id: 0, fullName: "repository", description: "description", language: "swift", stars: 10, watchers: 50, login: "vinsalmont", avatarURL: "https://www.google.com")]
        let viewModel = Repositories.FetchRepositories.ViewModel(displayedRepositories: displayedRepositories)

        // When
        sut.showRepositories(viewModel: viewModel)
        let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 0)

        // Then
        XCTAssertEqual(numberOfRows, displayedRepositories.count, "The number of items on the Table View should match the repositories array")
    }
}
