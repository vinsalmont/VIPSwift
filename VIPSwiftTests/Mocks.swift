//
//  Mock.swift
//  VIPSwiftTests
//
//  Created by vinsalmont on 18/12/20.
//

@testable import VIPSwift
import XCTest

struct Mocks {
    static let referenceModel = RepositoryModel(id: 0, name: "name", fullName: "fullName", owner: OwnerModel(id: 0, login: "vinsalmont", avatarUrl: "https://www.google.com", url: "https://www.github.com/vinsalmont"), url: "https://www.github.com/vinsalmont/VIPSwift", description: "description", language: "swift", stars: 10, watchers: 10, forks: 10, openIssues: 10)
    static let responseModel = RepositoriesResponseModel(totalCount: 1, items: [referenceModel])
    static let displayedRepository = Repositories.FetchRepositories.ViewModel.DisplayedRepository(id: 0, fullName: "fullName", description: "description", language: "swift", stars: 10, watchers: 10, login: "vinsalmont", avatarURL: "https://www.google.com")
    static let displayedRepositoryDetail = RepositoryDetail.GetRepository.ViewModel.DisplayedRepository(id: 0, fullName: "fullName", description: "description", language: "swift", stars: 10, watchers: 10, login: "vinsalmont", avatarURL: "https://www.google.com", openIssues: 10, forks: 10)
}
