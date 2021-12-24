//
//  GroupFeedViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit

protocol GroupFeedNavigationDelegate {
    func goToGroupDetails()
    func goToMyGroups()
    func presentErrorMessage(error: String)
}

final class GroupFeedViewController: UITableViewController {
    
    public var navigationDelegate: GroupFeedNavigationDelegate?
    
    
    // MARK: - Init
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 80, right: 0)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    // MARK: - Objective C Functions
    
    
    @objc private func didTapLeftNavBarItem() {
        navigationDelegate?.goToMyGroups()
    }
    
    
    @objc private func didTapRightNavBarItem() {
        navigationDelegate?.goToGroupDetails()
    }
    
    
    // MARK: - PRIVATE
    
    
    private func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.text.square"),
            style: .plain,
            target: self,
            action: #selector(didTapRightNavBarItem)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image:  UIImage(systemName: "globe"),
            style: .plain,
            target: self,
            action: #selector(didTapLeftNavBarItem)
        )
        
        navigationItem.titleView = HashTagView(text: "nyc-running-group", fontSize: 20)
    }
    
    
}
// MARK: - UITableView Data Source


extension GroupFeedViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    
}

