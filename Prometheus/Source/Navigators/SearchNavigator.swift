//
//  SearchNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/5/21.
//

import UIKit

protocol SearchCoordinatorDelegate {
    func goToPreviousTab()
}

final class SearchNavigator: UINavigationController {
    
    var coordinatorDelegate: SearchCoordinatorDelegate?
    
    init() {
        let rootViewController = SearchViewController()
        super.init(rootViewController: rootViewController)
        rootViewController.navigationDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .tertiaryTheme
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
    }
    
}


// MARK: - MainCoordinatorDelegate


extension SearchNavigator: TabCoordinatorDelegate {
    
    func primaryButtonTapped() {
        let viewController = ComposeNavigator()
        present(viewController, animated: true, completion: nil)
    }
    
}


// MARK: - SearchNavigationDelegate


extension SearchNavigator: SearchNavigationDelegate {
    
    func goToLastViewController() {
        coordinatorDelegate?.goToPreviousTab()
    }
    
}
