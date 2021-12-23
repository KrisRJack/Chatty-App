//
//  ComposeNavigator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/9/21.
//

import UIKit

final class ComposeNavigator: UINavigationController {
    
    init() {
        let rootViewController = ComposeViewController()
        super.init(rootViewController: rootViewController)
        rootViewController.navigationDelegate = self
        
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .tertiaryTheme
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
        
        view.backgroundColor = .clear
        navigationBar.backgroundColor = .clear

        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        visualEffectView.frame = view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(visualEffectView)
        view.sendSubviewToBack(visualEffectView)
    }
    
    
}

extension ComposeNavigator: ComposeNavigationDelegate {
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}