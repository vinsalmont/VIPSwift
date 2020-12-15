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
//    router.dataStore = interactor
  }

  // MARK: View lifecycle
  
  override func viewDidLoad()  {
    super.viewDidLoad()
  }

}

// MARK: RepositoryDetailDisplayLogic
extension RepositoryDetailViewController: RepositoryDetailDisplayLogic {
    func showRepository(viewModel: RepositoryDetail.GetRepository.ViewModel) {

    }
}
