//
//  MainTabCoordinator.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/5/21.
//

import UIKit

protocol TabCoordinatorDelegate {
    func primaryButtonTapped()
}

final class TabCoordinator: UITabBarController {
    
    private var viewModel: LaunchViewModel!
    private var lastPresentingIndex = 0
    private var primaryButtonHeight: CGFloat { 58 }
    
    public var navigationDelegate: TabCoordinatorDelegate?

    // MARK: Primary Button
    
    
    let primaryButtonShadow: UIView = {
        let shadow = UIView()
        shadow.layer.shadowRadius = 2
        shadow.layer.shadowOpacity = 1
        shadow.layer.masksToBounds = false
        shadow.layer.shadowColor = UIColor.softShadow.cgColor
        shadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        return shadow
    }()
    
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.quaternaryTheme.cgColor,
            UIColor.primaryTheme.cgColor,
        ]
        return gradientLayer
    }()
    
    
    lazy var primaryButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .semibold))
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.layer.cornerRadius = primaryButtonHeight.halfOf
        button.setImage(UIImage(systemName: "plus")?.withConfiguration(config), for: .normal)
        return button
    }()
    
    
    // MARK: View Controllers
    
    
    private lazy var groupFeedNavigator: GroupFeedNavigator = {
        let viewController = GroupFeedNavigator(viewModel: viewModel)
        viewController.tabBarItem = tabBarItem(title: "Feed", systemName: "square.text.square")
        return viewController
    }()
    
    
    private lazy var searchNavigator: SearchNavigator = {
        let viewController = SearchNavigator()
        viewController.coordinatorDelegate = self
        viewController.tabBarItem = tabBarItem(title: "Search", systemName: "magnifyingglass", withFill: false)
        return viewController
    }()
    
    
    private lazy var inboxNavigator: InboxNavigator = {
        let viewController = InboxNavigator()
        viewController.tabBarItem = tabBarItem(title: "DMs", systemName: "at", withFill: false)
        return viewController
    }()
    
    
    private lazy var profileNavigator: ProfileNavigator = {
        let viewController = ProfileNavigator()
        viewController.tabBarItem = tabBarItem(title: "You", systemName: "person.crop.circle")
        return viewController
    }()
    
    
    // MARK: - Init
    
    
    init(with vm: LaunchViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        addButtonToView()
        setUpTabBarAppearance()
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        
        navigationDelegate = groupFeedNavigator
        viewControllers = [groupFeedNavigator, searchNavigator, inboxNavigator, profileNavigator]
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        primaryButton.frame = primaryButtonShadow.bounds
        primaryButtonShadow.addSubview(primaryButton)
        gradientLayer.frame = primaryButton.bounds
        primaryButton.layer.insertSublayer(gradientLayer, at: 0)
        if let imageView = primaryButton.imageView {
            primaryButton.bringSubviewToFront(imageView)
        }
    }
    
    
    // MARK: - Objective C Functions
    
    
    @objc private func primaryButtonTapped() {
        Vibration.vibrate(with: .soft)
        navigationDelegate?.primaryButtonTapped()
    }
    
    
    // MARK: - PRIVATE
    
    
    private func addButtonToView() {
        view.addSubview(primaryButtonShadow, withConstraints: true)
        [primaryButtonShadow.heightAnchor.constraint(equalToConstant: primaryButtonHeight),
         primaryButtonShadow.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20),
         primaryButtonShadow.widthAnchor.constraint(equalTo: primaryButtonShadow.heightAnchor),
         primaryButtonShadow.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -6),
        ].activate()
    }
    
    
    private func setUpTabBarAppearance() {
        let appearance = tabBar.standardAppearance
        
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        
        appearance.stackedLayoutAppearance.normal.iconColor = .tertiaryTheme
        appearance.stackedLayoutAppearance.selected.iconColor = .tertiaryTheme
        appearance.compactInlineLayoutAppearance.normal.iconColor = .tertiaryTheme
        appearance.compactInlineLayoutAppearance.selected.iconColor = .tertiaryTheme
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.tertiaryTheme]
        
        tabBar.standardAppearance = appearance
    }
    
    
    private func tabBarItem(title: String?, systemName: String, withFill: Bool = true) -> UITabBarItem {
        UITabBarItem(
            title: title,
            image: UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16, weight: .medium))
            ),
            selectedImage: UIImage(
                systemName: withFill ? "\(systemName).fill" : systemName,
                withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16, weight: withFill ? .medium : .heavy))
            )
        )
    }
}


// MARK: - UITabBarControllerDelegate


extension TabCoordinator: UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        Vibration.vibrate(with: .soft)
        navigationDelegate = viewController as? TabCoordinatorDelegate
        
        if viewController.viewIfLoaded?.window == nil { return }
        guard let navigationController = viewController as? UINavigationController else { return }
        guard let tableViewController = navigationController.visibleViewController as? UITableViewController else { return }
        
        let tableView: UITableView = tableViewController.tableView
        let tableViewInsetWithMargins = tableView.layoutMargins.top + tableView.contentInset.top
        tableView.setContentOffset(CGPoint(x: 0, y: -tableViewInsetWithMargins), animated: true)
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        lastPresentingIndex = viewControllers?.firstIndex(of: fromVC) ?? 0
        return SlideTransition(viewControllers: tabBarController.viewControllers)
    }
    
}

// MARK: - SearchCoordinatorDelegate

extension TabCoordinator: SearchCoordinatorDelegate {
    
    func goToPreviousTab() {
        Vibration.vibrate(with: .soft)
        selectedIndex = lastPresentingIndex
    }
    
}
