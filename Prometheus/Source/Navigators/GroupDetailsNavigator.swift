//
//  GroupDetailsNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/6/21.
//

import UIKit

final class GroupDetailsNavigator: UINavigationController {
    
    init() {
        let rootViewController = GroupDetailsViewController()
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
        
        view.backgroundColor = .systemBackground
    }

}

extension GroupDetailsNavigator: GroupDetailsNavigationDelegate {
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}
