//
//  RepositoryModel.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import Foundation

struct RepositoryModel: Codable {
    let id: Int?
    let name: String?
    let fullName: String?
    let owner: OwnerModel?
    let url: String?
    let description: String?
    let language: String?
    let stars: Int?
    let watchers: Int?
    let forks: Int?
    let openIssues: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case url = "html_url"
        case description
        case language
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case forks
        case openIssues = "open_issues"
    }
}
