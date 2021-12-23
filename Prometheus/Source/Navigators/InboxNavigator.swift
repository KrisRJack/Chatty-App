//
//  NotificationsNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/5/21.
//

import UIKit

final class InboxNavigator: UINavigationController {
    
    init() {
        let rootViewController = InboxViewController()
        super.init(rootViewController: rootViewController)
        rootViewController.navigationDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .tertiaryTheme
        navigationBar.backgroundColor = .systemBackground
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
        view.backgroundColor = .systemBackground
    }
    
}


// MARK: - MainCoordinatorDelegate


extension InboxNavigator: TabCoordinatorDelegate {
    
    func primaryButtonTapped() {
        let viewController = ComposeNavigator()
        present(viewController, animated: true, completion: nil)
    }
    
}


// MARK: - NotificationsNavigationDelegate


extension InboxNavigator: InboxNavigationDelegate {
    
    func goToMessages() {
        let rootViewController = MessagesViewController()
        pushViewController(rootViewController, animated: true)
    }

}
