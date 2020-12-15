//
//  RepositoriesInteractor.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit

import Foundation

protocol RepositoriesBusinessLogic: class {
    func searchRepositories(request: Repositories.FetchRepositories.Request)
}

protocol RepositoriesDataStore {
    var repositories: [RepositoryModel]? { get }
}

class RepositoriesInteractor: RepositoriesDataStore {
    var presenter: RepositoriesPresentationLogic?
    var worker = RepositoriesWorker()
    var repositories: [RepositoryModel]?
}

// MARK: RepositoriesBusinessLogic
extension RepositoriesInteractor: RepositoriesBusinessLogic {
    func searchRepositories(request: Repositories.FetchRepositories.Request) {
        worker.searchRepositories(query: request.query, page: request.page, success: { (response) in
            let repositoriesReponse = Repositories.FetchRepositories.Response(totalCount: response.totalCount, items: response.items)
            self.presenter?.presentRepositories(response: repositoriesReponse)
        }, failure: { (error) in
            let repositoriesError = Repositories.FetchRepositories.Error(message: error.localizedDescription)
            self.presenter?.presentError(error: repositoriesError)
        })
    }
}
