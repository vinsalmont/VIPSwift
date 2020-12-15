//
//  RepositoryDetailModels.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 15/12/20.
//

import UIKit

enum RepositoryDetail {
    
    enum GetRepository {
        struct Request { }
        struct Response {
            var repository: RepositoryModel
        }
        struct ViewModel {
            struct DiplayedRepository {
                var id: Int
                var fullName: String
                var description: String
                var language: String
                var stars: Int
                var watchers: Int
                var login: String
                var avatarURL: String
                var openIssues: Int
                var forks: Int        }
            var displayedRepository: DiplayedRepository
        }
    }
}
