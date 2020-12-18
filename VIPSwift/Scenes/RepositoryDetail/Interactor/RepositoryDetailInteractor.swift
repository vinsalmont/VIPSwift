//
//  RepositoryDetailInteractor.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 15/12/20.
//

import UIKit

protocol RepositoryDetailBusinessLogic {
    func getRepository(request: RepositoryDetail.GetRepository.Request)
}

protocol RepositoryDetailDataStore {
    var repository: RepositoryModel? { get set }
}

class RepositoryDetailInteractor: RepositoryDetailDataStore {
    var presenter: RepositoryDetailPresentationLogic?
    var repository: RepositoryModel?
}

// MARK: RepositoriesBusinessLogic
extension RepositoryDetailInteractor: RepositoryDetailBusinessLogic {
    func getRepository(request: RepositoryDetail.GetRepository.Request) {
        guard let repository = repository else { return }
        let response = RepositoryDetail.GetRepository.Response(repository: repository)
        presenter?.showRepository(response: response)
    }
}
