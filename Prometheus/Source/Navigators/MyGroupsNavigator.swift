//
//  MyGroupsNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

final class MyGroupsNavigator: UINavigationController {
    
    init() {
        let rootViewController = MyGroupsViewController()
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
        view.backgroundColor = .systemBackground
    }

}

extension MyGroupsNavigator: MyGroupNavigationDelegate {
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}
