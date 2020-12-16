//
//  RepositoriesAPI.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import Alamofire

enum RepositoriesEndpoint {
    case search(query: String, page: Int)
}

extension RepositoriesEndpoint: Endpoint {
    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case let .search(query, page):
            return "\(Constants.BASE_URL)/search/repositories?q=\(query)&page=\(page)&per_page=30"
        }
    }

    var parameters: Parameters? {
        return nil
    }

    var header: HTTPHeaders? {
        return nil
    }

    var encoding: ParameterEncoding {
        return URLEncoding(destination: .queryString)
    }
}
