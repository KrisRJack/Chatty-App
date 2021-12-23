//
//  ProfileViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/5/21.
//

import UIKit

protocol ProfileNavigationDelegate {
    
}

final class ProfileViewController: UITableViewController {
    
    public var navigationDelegate: ProfileNavigationDelegate?
    
    private var didReloadOnWillAppear = false
    private let groupDetailsHeaderView = ProfileHeaderView()
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = groupDetailsHeaderView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 50, right: 0)
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: SubtitleCell.reuseIdentifier)
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !didReloadOnWillAppear {
            tableView.beginUpdates()
            tableView.endUpdates()
            didReloadOnWillAppear = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else { return }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
        }
        
    }
    
    private func setUpNavigationBar() {
        navigationItem.setLeftBarButtonItems([
            UIBarButtonItem(
                image:  UIImage(systemName: "qrcode"),
                style: .plain,
                target: self,
                action: nil
            ),
        ], animated: true)
        
        navigationItem.setRightBarButtonItems([
            UIBarButtonItem(
                image:  UIImage(systemName: "ellipsis"),
                style: .plain,
                target: self,
                action: nil
            ),
        ], animated: true)
        
        navigationItem.title = "KrisRJack"
    }
    
    // MARK: - UITableView Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileModel.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ProfileModel.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ProfileModel.sections[section].footer
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = ProfileModel.sections[indexPath.section].rows[indexPath.row]
        
        let cell = SubtitleCell(reuseIdentifier: SubtitleCell.reuseIdentifier)
        
        cell.configure(with: SubtitleCellModel(
            titleString: item.title,
            detailString: item.description,
            iconImage: UIImage(systemName: item.systemImageName ?? ""),
            accessoryType: item.accessoryType
        ))
        
        return cell
    }
    
}
