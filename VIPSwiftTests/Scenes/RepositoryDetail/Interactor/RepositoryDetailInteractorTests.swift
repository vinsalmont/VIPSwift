//
//  RepositoryDetailInteractorTests.swift
//  VIPSwiftTests
//
//  Created by vinsalmont on 18/12/20.
//

@testable import VIPSwift
import XCTest

class RepositoryDetailInteractorTest: XCTestCase {
    
    // MARK: - Subject under test
    var sut: RepositoryDetailInteractor!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        setupRepositoryDetailInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // NARK: - Test Setup
    func setupRepositoryDetailInteractor() {
        sut = RepositoryDetailInteractor()
    }
    
    // MARK: - Test doubles
    class RepositoryDetailPresentationLogicSpy: RepositoryDetailPresentationLogic {
        var showRepositoryCalled = false
        
        func showRepository(response: RepositoryDetail.GetRepository.Response) {
            showRepositoryCalled = true
        }
    }
    
    
    // MARK: - Tests
    func testShouldShowRepository() {
        // Given
        let presenterSpy = RepositoryDetailPresentationLogicSpy()
        sut.presenter = presenterSpy
        sut.repository = Mocks.referenceModel
        
        // When
        let request = RepositoryDetail.GetRepository.Request()
        sut.getRepository(request: request)
        
        // Then
        XCTAssert(presenterSpy.showRepositoryCalled, "Should've asked the presenter to format the repository")
    }
}
