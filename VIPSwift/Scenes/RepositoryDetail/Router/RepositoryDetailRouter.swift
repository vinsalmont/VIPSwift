//
//  RepositoryDetailRouter.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 15/12/20.
//

import UIKit

@objc protocol RepositoryDetailRoutingLogic {
}

protocol RepositoryDetailDataPassing {
    var dataStore: RepositoryDetailDataStore? { get set }
}

class RepositoryDetailRouter: NSObject, RepositoryDetailRoutingLogic, RepositoryDetailDataPassing {
    weak var viewController: RepositoryDetailViewController?
    var dataStore: RepositoryDetailDataStore?
}
