//
//  PostDetailViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/21/22.
//

import UIKit


final class PostDetailViewController: UITableViewController {
    
    
    private var viewModel: PostViewModelType!
    
    
    // MARK: - Init
    
    
    init(viewModel: PostViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.beginUpdates()
        tableView.endUpdates()
        setUpTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    // MARK: - UITableView Data Source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath)
        (cell as? PostCell)?.configure(with: viewModel)
        return cell
    }
    
    
    // MARK: - PRIVATE
    
    
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
    
}
