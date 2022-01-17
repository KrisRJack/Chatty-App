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
    
    
    public var navigationDelegate: ComposePreviewNavigationDelegate?
    
    
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
        animatedEntrance()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            animatedExit()
        }
    }
    
    
    // MARK: - Private
    
    
    private func animatedEntrance() {
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 1
        }
    }
    
    
    private func animatedExit() {
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 0
            self.navigationDelegate?.goBackToEditPost()
        }
    }
    
    
    private func setUpViews() {
        view.addSubview(tableView, withConstraints: true)
        [tableView.topAnchor.constraint(equalTo: view.topAnchor),
         tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
         tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
    }
    
}


// MARK: - UITableViewDataSource


extension ComposePreviewViewController: UITableViewDataSource {
    
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection[section] ?? 0
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath)
        (cell as? PostCell)?.configure(with: viewModel.viewModelForPost)
        return cell
    }
    
    
}
