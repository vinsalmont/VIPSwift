//
//  RepositoryDetailPresenter.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 15/12/20.
//

import UIKit

protocol RepositoryDetailPresentationLogic {
    func showRepository(response: RepositoryDetail.GetRepository.Response)
}

class RepositoryDetailPresenter: RepositoryDetailPresentationLogic {
    weak var viewController: RepositoryDetailDisplayLogic?
    
    func showRepository(response: RepositoryDetail.GetRepository.Response) {
        let displayedRepository = RepositoryDetail.GetRepository.ViewModel.DiplayedRepository(
            id: response.repository.id ?? 0,
            fullName: response.repository.fullName ?? "",
            description: response.repository.description ?? "",
            language: response.repository.language ?? "",
            stars: response.repository.stars ?? 0,
            watchers: response.repository.watchers ?? 0,
            login: response.repository.owner?.login ?? "",
            avatarURL: response.repository.owner?.avatarUrl ?? "",
            openIssues: response.repository.openIssues ?? 0,
            forks: response.repository.forks ?? 0
        )
        let viewModel = RepositoryDetail.GetRepository.ViewModel(displayedRepository: displayedRepository)
        viewController?.showRepository(viewModel: viewModel)
    }
}
