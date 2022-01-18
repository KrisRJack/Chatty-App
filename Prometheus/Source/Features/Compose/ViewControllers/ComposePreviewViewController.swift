//
//  ComposePreviewViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/12/22.
//

import UIKit

protocol ComposePreviewNavigationDelegate {
    func goBackToEditPost()
}


final class ComposePreviewViewController: UIViewController {
    
    
    private var viewModel: ComposePreviewViewModel!
    private let tableView: UITableView = UITableView()
    
    private var primaryButtonHeight: CGFloat { 45 }
    public var navigationDelegate: ComposePreviewNavigationDelegate?
    
    
    // MARK: - Views
    
    
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
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.setTitle("Post", for: .normal)
        button.layer.cornerRadius = primaryButtonHeight.halfOf
        button.titleLabel?.font = .preferredFont(forTextStyle: .callout, weight: .bold)
        return button
    }()
    
    
    // MARK: - Init
    
    
    init(viewModel: ComposePreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setUpViews()
        setUpTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
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
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            navigationDelegate?.goBackToEditPost()
        }
    }
    
    
    // MARK: - Private
    
    
    private func animatedEntrance() {
        UIView.animate(withDuration: 1) {
            self.tableView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    
    private func animatedExit() {
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 0
            self.navigationDelegate?.goBackToEditPost()
        }
    }
    
    
    private func setUpViews() {
        view.addSubviews([
            tableView,
            primaryButtonShadow
        ], withConstraints: true)
        [tableView.topAnchor.constraint(equalTo: view.topAnchor),
         tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
         tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         primaryButtonShadow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         primaryButtonShadow.heightAnchor.constraint(equalToConstant: primaryButtonHeight),
         primaryButtonShadow.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20),
         primaryButtonShadow.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
        ].activate()
    }
    
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: (70 + view.layoutMargins.bottom + primaryButtonHeight), right: 0)
        tableView.register(ComposePreviewHeaderCell.self, forCellReuseIdentifier: ComposePreviewHeaderCell.reuseIdentifier)
    }
    
}


// MARK: - UITableViewDataSource


extension ComposePreviewViewController: UITableViewDataSource {
    
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.numberOfRowsInSection[section] ?? 0) + 1
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            return tableView.dequeueReusableCell(withIdentifier: ComposePreviewHeaderCell.reuseIdentifier, for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath)
        (cell as? PostCell)?.configure(with: viewModel.viewModelForPost)
        return cell
    }
    
    
}
