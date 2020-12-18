//
//  RepositoryDetailPresenterTests.swift
//  VIPSwiftTests
//
//  Created by vinsalmont on 18/12/20.
//

@testable import VIPSwift
import XCTest

class RepositoryDetailPresenterTests: XCTestCase {
    // MARK: - Subject under test
    var sut: RepositoryDetailPresenter!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        setupRepositoryDetailPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    func setupRepositoryDetailPresenter() {
        sut = RepositoryDetailPresenter()
    }
    
    // MARK: - Test Doubles
    class RepositoryDetailDisplayLogicSpy: RepositoryDetailDisplayLogic {
        var showRepositoryCalled = false
        
        var viewModel: RepositoryDetail.GetRepository.ViewModel!
        
        func showRepository(viewModel: RepositoryDetail.GetRepository.ViewModel) {
            showRepositoryCalled = true
            self.viewModel = viewModel
        }
    }
    
    // MARK: - Tests
    func testShouldFormatRepositories() {
        // Given
        let viewControllerSpy = RepositoryDetailDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        // When
        let response = RepositoryDetail.GetRepository.Response(repository: Mocks.referenceModel)
        sut.showRepository(response: response)
        
        // Then
        let displayedRepository = viewControllerSpy.viewModel.displayedRepository
        XCTAssertEqual(displayedRepository.id, Mocks.referenceModel.id, "The presenter should properly format the id")
        XCTAssertEqual(displayedRepository.fullName, Mocks.referenceModel.fullName, "The presenter should properly format the full name")
        XCTAssertEqual(displayedRepository.description, Mocks.referenceModel.description, "The presenter should properly format the description")
        XCTAssertEqual(displayedRepository.language, Mocks.referenceModel.language, "The presenter should properly format the language")
        XCTAssertEqual(displayedRepository.stars, Mocks.referenceModel.stars, "The presenter should properly format the starts")
        XCTAssertEqual(displayedRepository.watchers, Mocks.referenceModel.watchers, "The presenter should properly format the watchers")
        XCTAssertEqual(displayedRepository.login, Mocks.referenceModel.owner?.login, "The presenter should properly format the login")
        XCTAssertEqual(displayedRepository.avatarURL, Mocks.referenceModel.owner?.avatarUrl, "The presenter should properly format the avatar url")
        XCTAssertEqual(displayedRepository.openIssues, Mocks.referenceModel.openIssues, "The presenter should properly format the open issues")
        XCTAssertEqual(displayedRepository.forks, Mocks.referenceModel.forks, "The presenter should properly format the forks")
    }
    
    func testShouldShowRepositoriesCalled() {
        // Given
        let viewControllerSpy = RepositoryDetailDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        // When
        let response = RepositoryDetail.GetRepository.Response(repository: Mocks.referenceModel)
        sut.showRepository(response: response)
     
        // Then
        XCTAssert(viewControllerSpy.showRepositoryCalled, "The Presenter should have called the show repositories scenario")
    }

}
