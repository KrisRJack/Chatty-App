//
//  GroupFeedNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit

final class GroupFeedNavigator: UINavigationController {
    
    init(viewModel: LaunchViewModel) {
        let rootViewController = GroupFeedViewController(viewModel: viewModel)
        super.init(rootViewController: rootViewController)
        rootViewController.navigationDelegate = self
        rootViewController.engagementBannerNavigationDelegate = self
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

extension GroupFeedNavigator: TabCoordinatorDelegate {
    
    func primaryButtonTapped() {
        let viewController = ComposeNavigator()
        present(viewController, animated: true, completion: nil)
    }
    
}

extension GroupFeedNavigator: GroupFeedNavigationDelegate {
    
    func goToPostDetails(with viewModel: PostViewModelType) {
        let viewController = PostDetailViewController(viewModel: viewModel)
        pushViewController(viewController, animated: true)
    }
    
    func goToMyGroups() {
        let viewController = MyGroupsViewController()
        viewController.navigationDelegate = self
        pushViewController(viewController, animated: true)
    }
    
    func goToGroupDetails() {
        let viewController = GroupDetailsNavigator() 
        present(viewController, animated: true, completion: nil)
    }
    
    func presentErrorMessage(error: String) {
        // TODO: Present Error Message
    }
    
}

extension GroupFeedNavigator: MyGroupNavigationDelegate {
    
    func dismiss() {
        popViewController(animated: true)
    }
    
}

extension GroupFeedNavigator: GroupDetailsNavigationDelegate {
    
    func dismissGroupDetails() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GroupFeedNavigator: EngagementBannerNavigationDelegate {
    
    func performRepostNavigation(with viewModel: PostViewModelType) {
        let viewController = ComposeNavigator(with: viewModel)
        present(viewController, animated: true, completion: nil)
    }
    
}
