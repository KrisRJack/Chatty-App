//
//  GroupFeedNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit

final class GroupFeedNavigator: UINavigationController {
    
    init() {
        
        let group = Group(
            id: "aaeNEdIGXu3aZcWfQCP6",
            name: "NYC Running Group",
            hashtag: "nyc-running-group",
            createdOn: Date(),
            createdByUserID: "testuserid",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        )
        
        
        let viewModel = GroupFeedViewModel(group: group)
        let rootViewController = GroupFeedViewController(viewModel: viewModel)
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

extension GroupFeedNavigator: TabCoordinatorDelegate {
    
    func primaryButtonTapped() {
        let viewController = ComposeNavigator()
        present(viewController, animated: true, completion: nil)
    }
    
}

extension GroupFeedNavigator: GroupFeedNavigationDelegate {
    
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
