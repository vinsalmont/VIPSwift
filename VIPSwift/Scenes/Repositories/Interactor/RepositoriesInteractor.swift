//
//  RepositoriesInteractor.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import Foundation

protocol RepositoriesBusinessLogic: class {
    func searchRepositories(request: Repositories.FetchRepositories.Request)
}

protocol RepositoriesDataStore {
    var repositories: [RepositoryModel]? { get set }
}

class RepositoriesInteractor: RepositoriesBusinessLogic, RepositoriesDataStore {
    var presenter: RepositoriesPresentationLogic?
    var worker = RepositoriesWorker()
    var repositories: [RepositoryModel]?
    
    func searchRepositories(request: Repositories.FetchRepositories.Request) {
        worker.searchRepositories(query: request.query, page: request.page, success: { (response) in
            let repositoriesReponse = Repositories.FetchRepositories.Response(totalCount: response.totalCount, items: response.items)

            if request.page == 1 {
                self.repositories = repositoriesReponse.items
            } else {
                self.repositories?.append(contentsOf: repositoriesReponse.items)
            }

            self.presenter?.presentRepositories(response: repositoriesReponse)
        }, failure: { (error) in
            self.repositories = []

            let repositoriesError = Repositories.FetchRepositories.Error(message: error)

            self.presenter?.presentError(error: repositoriesError)
        })
    }
}
