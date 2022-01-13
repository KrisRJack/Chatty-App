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
    
    init(with viewModel: PostViewModel) {
        let rootViewController = ComposeViewController(with: viewModel)
        super.init(rootViewController: rootViewController)
        rootViewController.navigationDelegate = self
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        removeCurrentBackground()
        addBlurBackgroundColor()
        interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func setUpNavigationBar() {
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .tertiaryTheme
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
    }
    
    private func removeCurrentBackground() {
        view.backgroundColor = .clear
        navigationBar.backgroundColor = .clear
    }
    
    private func addBlurBackgroundColor() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
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
    
    func goToComposePreview() {
        let viewController = ComposePreviewViewController()
        viewController.navigationDelegate = self
        pushViewController(viewController, animated: true)
    }
    
}


extension ComposeNavigator: ComposePreviewNavigationDelegate {
    
    func goBackToEditPost() {
        popViewController(animated: true)
    }
    
}
