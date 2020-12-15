//
//  RepositoriesResponseModel.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import Foundation

struct RepositoriesResponseModel: Codable {
    let totalCount: Int
    let items: [RepositoryModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
