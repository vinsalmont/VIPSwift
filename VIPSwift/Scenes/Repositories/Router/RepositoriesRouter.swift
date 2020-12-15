//
//  RepositoriesRouter.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit

protocol RepositoriesRoutingLogic {
    func showRepositoryDetail(selectedRow: Int)
}

protocol RepositoriesDataPassing {
    var dataStore: RepositoriesDataStore? { get }
}

class RepositoriesRouter: NSObject, RepositoriesDataPassing, RepositoriesRoutingLogic {
    weak var viewController: RepositoriesViewController?
    var dataStore: RepositoriesDataStore?
    
    func showRepositoryDetail(selectedRow: Int) {
        if let navigationController = viewController?.navigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "RepositoryDetailViewController") as? RepositoryDetailViewController else { return }
            
            detailViewController.router?.dataStore?.repository = viewController?.router?.dataStore?.repositories?[selectedRow]
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}

