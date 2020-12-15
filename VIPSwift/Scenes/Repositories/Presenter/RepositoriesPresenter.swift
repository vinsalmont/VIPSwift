//
//  RepositoriesPresenter.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit

protocol RepositoriesPresentationLogic: class {
    func presentError(error: Repositories.FetchRepositories.Error)
    func presentRepositories(response: Repositories.FetchRepositories.Response)
}

class RepositoriesPresenter: RepositoriesPresentationLogic{
    weak var viewController: RepositoriesDisplayLogic?

    func presentError(error: Repositories.FetchRepositories.Error) {
        viewController?.showError(message: error.message)
    }

    func presentRepositories(response: Repositories.FetchRepositories.Response) {
        let displayedRepositories = response.items.map {
            Repositories.FetchRepositories.ViewModel.DisplayedRepository(id: $0.id ?? 0,
                                                                         fullName: $0.fullName ?? "",
                                                                         description: $0.description ?? "",
                                                                         language: $0.language ?? "",
                                                                         stars: $0.stars ?? 0,
                                                                         watchers: $0.watchers ?? 0,
                                                                         login: $0.owner?.login ?? "",
                                                                         avatarURL: $0.owner?.avatarUrl ?? "")
        }

        let viewModel = Repositories.FetchRepositories.ViewModel(displayedRepositories: displayedRepositories)
        viewController?.showRepositories(viewModel: viewModel)
    }
}
