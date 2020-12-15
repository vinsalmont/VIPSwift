//
//  RepositoriesWorker.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit

protocol RepositoriesWorkerProtocol: class {
    func searchRepositories(query: String, page: Int, success: @escaping ((RepositoriesResponseModel) -> Void), failure: @escaping ((Error) -> Void))
}

class RepositoriesWorker: RepositoriesWorkerProtocol {
    func searchRepositories(query: String,
                            page: Int,
                            success: @escaping ((RepositoriesResponseModel) -> Void),
                            failure: @escaping ((Error) -> Void)) {

        NetworkService.shared.request(endpoint: RepositoriesEndpoint.search(query: query, page: page), success: { (responseData) in
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(RepositoriesResponseModel.self, from: responseData)
                success(data)
            } catch let error {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
}
