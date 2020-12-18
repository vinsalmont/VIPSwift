//
//  RepositoryDetailViewControllerTests.swift
//  VIPSwiftTests
//
//  Created by vinsalmont on 18/12/20.
//

@testable import VIPSwift
import XCTest

class RepositoryDetailViewControllerTests: XCTestCase {
    
    var sut: RepositoryDetailViewController!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        setupRepositoryDetailViewController()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Setup
    func setupRepositoryDetailViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(identifier: "RepositoryDetailViewController") as? RepositoryDetailViewController
        _ = sut.view
    }

    // MARK: - Spys
    class RepositoryDetailBusinessLogicSpy: RepositoryDetailBusinessLogic {
        var repository: RepositoryModel?

        var getRepositoryCalled = false

        func getRepository(request: RepositoryDetail.GetRepository.Request) {
            getRepositoryCalled = true
        }
    }


    // MARK: - Tests

    func testShouldDisplayRepository() {
        // Given
        let repositoryDetailBusinessLogicSpy = RepositoryDetailBusinessLogicSpy()
        sut.interactor = repositoryDetailBusinessLogicSpy
        _ = sut.view



        // When
        sut.viewWillAppear(true)

        // Then
        XCTAssert(repositoryDetailBusinessLogicSpy.getRepositoryCalled, "It should have called the getRepository method")

    }
    
    func testShouldPopulateTheViewCorrectly() {
        // Given
        let displayedRepository = Mocks.displayedRepositoryDetail
        let viewModel = RepositoryDetail.GetRepository.ViewModel(displayedRepository: displayedRepository)

        // When
        sut.showRepository(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.repositoryNameLabel.text, Mocks.referenceModel.fullName)
        XCTAssertEqual(sut.repositoryDescriptionLabel.text, Mocks.referenceModel.description)
        XCTAssertEqual(sut.repositoryLanguageLabel.text, Mocks.referenceModel.language)
        XCTAssertEqual(sut.repositoryForksLabel.text, "\(Mocks.referenceModel.forks!)")
        XCTAssertEqual(sut.repositoryStarsLabel.text, "\(Mocks.referenceModel.stars!)")
        XCTAssertEqual(sut.repositoryWatchersLabel.text, "\(Mocks.referenceModel.watchers!)")

    }

}
