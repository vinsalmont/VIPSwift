//
//  RepositoriesPresenterTests.swift
//  VIPSwiftTests
//
//  Created by vinsalmont on 18/12/20.
//

@testable import VIPSwift
import XCTest

class RepositoriesPresenterTests: XCTestCase {
    // MARK: - Subject under test
    var sut: RepositoriesPresenter!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        setupRepositoriesPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    func setupRepositoriesPresenter() {
        sut = RepositoriesPresenter()
    }
    
    // MARK: - Test Doubles
    class RepositoriesDisplayLogicSpy: RepositoriesDisplayLogic {
        var showRepositoriesCalled = false
        var showErrorCalled = false
        
        var viewModel: Repositories.FetchRepositories.ViewModel!
        var errorMessage: String!
        
        func showRepositories(viewModel: Repositories.FetchRepositories.ViewModel) {
            showRepositoriesCalled = true
            self.viewModel = viewModel
        }
        
        func showError(message: String) {
            showErrorCalled = true
            errorMessage = message
        }
    }
    
    // MARK: - Tests
    func testShouldFormatRepositories() {
        // Given
        let viewControllerSpy = RepositoriesDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        // When
        let response = Repositories.FetchRepositories.Response(totalCount: 1, items: Mocks.responseModel.items)
        sut.presentRepositories(response: response)
        
        // Then
        let displayedRepositories = viewControllerSpy.viewModel.displayedRepositories
        for displayedRepository in displayedRepositories {
            XCTAssertEqual(displayedRepository.id, Mocks.referenceModel.id, "The presenter should properly format the id")
            XCTAssertEqual(displayedRepository.fullName, Mocks.referenceModel.fullName, "The presenter should properly format the full name")
            XCTAssertEqual(displayedRepository.description, Mocks.referenceModel.description, "The presenter should properly format the description")
            XCTAssertEqual(displayedRepository.language, Mocks.referenceModel.language, "The presenter should properly format the language")
            XCTAssertEqual(displayedRepository.stars, Mocks.referenceModel.stars, "The presenter should properly format the starts")
            XCTAssertEqual(displayedRepository.watchers, Mocks.referenceModel.watchers, "The presenter should properly format the watchers")
            XCTAssertEqual(displayedRepository.login, Mocks.referenceModel.owner?.login, "The presenter should properly format the login")
            XCTAssertEqual(displayedRepository.avatarURL, Mocks.referenceModel.owner?.avatarUrl, "The presenter should properly format the avatar url")
        }
    }
    
    func testShouldShowRepositoriesCalled() {
        // Given
        let viewControllerSpy = RepositoriesDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        // When
        let response = Repositories.FetchRepositories.Response(totalCount: 1, items: Mocks.responseModel.items)
        sut.presentRepositories(response: response)
     
        // Then
        XCTAssert(viewControllerSpy.showRepositoriesCalled, "The Presenter should have called the show repositories scenario")
    }
    
    func testShouldPresentError() {
        // Given
        let viewControllerSpy = RepositoriesDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        // When
        let repositoryError = Repositories.FetchRepositories.Error(message: "error")
        sut.presentError(error: repositoryError)
        
        // Then
        XCTAssert(viewControllerSpy.showErrorCalled, "The Presenter should have called the error scenario")
    }
}
