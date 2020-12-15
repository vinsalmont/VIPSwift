//
//  RepositoriesModels.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit

enum Repositories {
    enum FetchRepositories {
        struct Request {
            var query: String
            var page: Int
        }

        struct Response {
            var totalCount: Int
            var items: [RepositoryModel]
        }

        struct Error {
            var message: String
        }

        struct ViewModel {
            struct DisplayedRepository {
                var id: Int
                var fullName: String
                var description: String
                var language: String
                var stars: Int
                var watchers: Int
                var login: String
                var avatarURL: String
            }
            var displayedRepositories: [DisplayedRepository]
        }
    }
}
