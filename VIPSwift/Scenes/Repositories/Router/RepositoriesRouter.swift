//
//  RepositoriesRouter.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit

@objc protocol RepositoriesRoutingLogic {
//    func showRepositoryDetail(source: RepositoriesViewController, destination: Reposi)
}

protocol RepositoriesDataPassing {
    var dataStore: RepositoriesDataStore? { get }
}

class RepositoriesRouter: NSObject {
    weak var viewController: RepositoriesViewController?
    var dataStore: RepositoriesDataStore?
}

extension RepositoriesRouter: RepositoriesRoutingLogic {
//    func showRepositoryDetail() {
//
//    }
}

