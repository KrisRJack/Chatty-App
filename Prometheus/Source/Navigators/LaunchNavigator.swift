//
//  LaunchNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/4/22.
//

import UIKit

final class LaunchNavigator: UINavigationController {
    
    init() {
        
        let group = Group(
            id: "aaeNEdIGXu3aZcWfQCP6",
            name: "NYC Running Group",
            hashtag: "nyc-running-group",
            createdOn: Date(),
            createdByUserID: "testuserid",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        )
        
        let viewModel = LaunchViewModel(group: group)
        let rootViewController = LaunchViewController(with: viewModel)
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


extension LaunchNavigator: LaunchNavigationDelegate {
    
    func goToMainController(with viewModel: LaunchViewModel) {
        UIApplication.keyWindow?.rootViewController = TabCoordinator(with: viewModel)
        UIApplication.keyWindow?.makeKeyAndVisible()
    }
    
}
