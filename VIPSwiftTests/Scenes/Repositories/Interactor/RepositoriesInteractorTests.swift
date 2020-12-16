//
//  RepositoriesInteractorTests.swift
//  VIPSwiftTests
//
//  Created by vinsalmont on 15/12/20.
//

@testable import VIPSwift
import XCTest

class RepositoriesInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: RepositoriesInteractor!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        setupRepositoriesInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    func setupRepositoriesInteractor() {
        sut = RepositoriesInteractor()
    }
    
    // MARK: - Test doubles
    class RepositoriesPresentationLogicSpy: RepositoriesPresentationLogic {        
        var presentErrorCalled = false
        var presentRepositoriesCalled = false
        
        
        func presentError(error: Repositories.FetchRepositories.Error) {
            presentErrorCalled = true
        }
        
        func presentRepositories(response: Repositories.FetchRepositories.Response) {
            presentRepositoriesCalled = true
        }
    }
    
    class RepositoriesSuccessWorkerSpy: RepositoriesWorker {
        var searchRepositoriesCalled = false
        
        override func searchRepositories(query: String, page: Int, success: @escaping ((RepositoriesResponseModel) -> Void), failure: @escaping ((String) -> Void)) {
            searchRepositoriesCalled = true
            
            success(RepositoriesResponseModel(totalCount: 1, items: [RepositoryModel(id: 0, name: "name", fullName: "fullName", owner: OwnerModel(id: 0, login: "vinsalmont", avatarUrl: "https://www.google.com", url: "https://www.github.com/vinsalmont"), url: "https://www.github.com/vinsalmont/VIPSwift", description: "description", language: "swift", stars: 10, watchers: 10, forks: 0, openIssues: 0)]))
        }
    }
    
    class RepositoriesFailureWorkerSpy: RepositoriesWorker {
        var searchRepositoriesCalled = false
        
        override func searchRepositories(query: String, page: Int, success: @escaping ((RepositoriesResponseModel) -> Void), failure: @escaping ((String) -> Void)) {
            searchRepositoriesCalled = true
            
            failure("error")
        }
    }
    // MARK: - Tests
    func testShouldFetchFromWorker() {
        // Given
        let presenterSpy = RepositoriesPresentationLogicSpy()
        sut.presenter = presenterSpy
        let workerSpy = RepositoriesSuccessWorkerSpy()
        sut.worker = workerSpy
        
        // When
        let request = Repositories.FetchRepositories.Request(query: "", page: 1)
        sut.searchRepositories(request: request)
        
        // Then
        XCTAssert(workerSpy.searchRepositoriesCalled, "Should've asked Worker to search the repositories")
        XCTAssert(presenterSpy.presentRepositoriesCalled, "Should've asked the presenter to format the results")
        XCTAssertFalse(presenterSpy.presentErrorCalled, "Shouldn't have presented the error")
    }
    
    func testShouldNotFetchFromWorker() {
        // Given
        let presenterSpy = RepositoriesPresentationLogicSpy()
        sut.presenter = presenterSpy
        let workerSpy = RepositoriesFailureWorkerSpy()
        sut.worker = workerSpy
        
        // When
        let request = Repositories.FetchRepositories.Request(query: "", page: 1)
        sut.searchRepositories(request: request)
        
        // Then
        XCTAssert(workerSpy.searchRepositoriesCalled, "Should've asked Worker to search the repositories")
        XCTAssertFalse(presenterSpy.presentRepositoriesCalled, "Shouldn't have asked the presenter to format the results")
        XCTAssert(presenterSpy.presentErrorCalled, "Should've presented the error")
    }
}
