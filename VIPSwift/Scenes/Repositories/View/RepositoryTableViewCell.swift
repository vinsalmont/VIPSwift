//
//  RepositoryTableViewCell.swift
//  GithubRepositories
//
//  Created by Vinicius Salmont on 14/12/20.
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var repositoryLanguageLabel: UILabel!
    @IBOutlet weak var startsCountLabel: UILabel!

    func setup(viewModel: Repositories.FetchRepositories.ViewModel.DisplayedRepository) {
        userAvatarImageView.download(url: viewModel.avatarURL)
        repositoryNameLabel.text = viewModel.fullName
        repositoryDescriptionLabel.text = viewModel.description
        repositoryLanguageLabel.text = viewModel.language
        startsCountLabel.text = "\(viewModel.stars)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        userAvatarImageView.image = nil
        self.repositoryNameLabel.text = ""
        self.repositoryDescriptionLabel.text = ""
        self.repositoryNameLabel.text = ""
        self.startsCountLabel.text = ""
    }

}
