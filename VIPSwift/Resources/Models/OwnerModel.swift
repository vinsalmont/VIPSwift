//
//  OwnerModel.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import Foundation

struct OwnerModel: Codable {
    let id: Int?
    let login: String?
    let avatarUrl: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case url = "html_url"
    }
}
