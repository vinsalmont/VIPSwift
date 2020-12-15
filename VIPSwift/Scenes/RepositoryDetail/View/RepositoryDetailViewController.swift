//
//  RepositoryDetailViewController.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 15/12/20.
//

import UIKit

protocol RepositoryDetailDisplayLogic: class {
    func showRepository(viewModel: RepositoryDetail.GetRepository.ViewModel)
}

class RepositoryDetailViewController: UIViewController {
    var interactor: RepositoryDetailBusinessLogic?
    var router: (NSObjectProtocol & RepositoryDetailRoutingLogic & RepositoryDetailDataPassing)?
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var repositoryLanguageLabel: UILabel!
    @IBOutlet weak var repositoryForksLabel: UILabel!
    @IBOutlet weak var repositoryStarsLabel: UILabel!
    @IBOutlet weak var repositoryWatchersLabel: UILabel!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RepositoryDetailInteractor()
        let presenter = RepositoryDetailPresenter()
        let router = RepositoryDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()  {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRepository()
    }
    
    // MARK: Get Repository
    private func getRepository() {
        let request = RepositoryDetail.GetRepository.Request()
        interactor?.getRepository(request: request)
    }
    
}

// MARK: RepositoryDetailDisplayLogic
extension RepositoryDetailViewController: RepositoryDetailDisplayLogic {
    func showRepository(viewModel: RepositoryDetail.GetRepository.ViewModel) {
        title = viewModel.displayedRepository.fullName
        userAvatarImageView.download(url: viewModel.displayedRepository.avatarURL)
        repositoryNameLabel.text = viewModel.displayedRepository.fullName
        repositoryDescriptionLabel.text = viewModel.displayedRepository.description
        repositoryLanguageLabel.text = viewModel.displayedRepository.language
        repositoryStarsLabel.text = "\(viewModel.displayedRepository.stars)"
        repositoryWatchersLabel.text = "\(viewModel.displayedRepository.watchers)"
        repositoryForksLabel.text = "\(viewModel.displayedRepository.forks)"
    }
}
