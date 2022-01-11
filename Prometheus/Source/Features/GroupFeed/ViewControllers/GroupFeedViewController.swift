//
//  GroupFeedViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit


protocol GroupFeedNavigationDelegate {
    func goToMyGroups()
    func goToGroupDetails()
    func presentErrorMessage(error: String)
}

final class GroupFeedViewController: UITableViewController {
    
    
    private var viewModel: LaunchViewModel!
    public var navigationDelegate: GroupFeedNavigationDelegate?
    public var engagementBannerNavigationDelegate: EngagementBannerNavigationDelegate?
    
    
    // MARK: - Init
    
    
    init(viewModel vm: LaunchViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
//        viewModel.reloadData = ({ self.tableView.reloadData() })
//        viewModel.reloadAt = ({ self.tableView.reloadRows(at: [$0], with: .fade) })
//        viewModel.presentErrorMessage = ({ self.navigationDelegate?.presentErrorMessage(error: $0) })
//        viewModel.loadInitialBatch()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpNavigationBar()
        addRefreshControlToTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    // MARK: - UITableView Data Source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.viewModelForCell(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath)
        (cell as? PostCell)?.engagementBannerNavigationDelegate = engagementBannerNavigationDelegate
        (cell as? PostCell)?.configure(with: viewModel)
        return cell
    }
    
    
    // MARK: - Objective C Functions
    
    
    @objc private func didPullToRefresh() {
//        viewModel.loadNewerBatch()
    }
    
    
    @objc private func didTapRightNavBarItem() {
        navigationDelegate?.goToMyGroups()
    }
    
    
    @objc private func didTapLeftNavBarItem() {
        navigationDelegate?.goToGroupDetails()
    }
    
    
    // MARK: - PRIVATE
    
    
    private func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.text.square"),
            style: .plain,
            target: self,
            action: #selector(didTapLeftNavBarItem)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image:  UIImage(systemName: "globe"),
            style: .plain,
            target: self,
            action: #selector(didTapRightNavBarItem)
        )
        
        navigationItem.titleView = HashTagView(text: viewModel.navigationTitle, fontSize: 20)
    }
    
    
    private func setUpTableView() {
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 80, right: 0)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
    }
    
    
    private func addRefreshControlToTableView() {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
//        tableView.addSubview(refreshControl)
//        viewModel.endRefreshing = ({ refreshControl.endRefreshing() })
    }
    
    
}

