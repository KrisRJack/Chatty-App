//
//  InboxViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/5/21.
//

import UIKit

protocol InboxNavigationDelegate {
    func goToMessages()
}

final class InboxViewController: UITableViewController {
    
    public var navigationDelegate: InboxNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        view.backgroundColor = .systemBackground
        
        tableView.separatorInset = .zero
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.register(MessagePreviewCell.self, forCellReuseIdentifier: MessagePreviewCell.reuseIdentifier)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    private func setUpNavigationBar() {
        navigationItem.setRightBarButtonItems([
            UIBarButtonItem(
                image:  UIImage(systemName: "at.badge.plus"),
                style: .plain,
                target: self,
                action: nil
            ),
        ], animated: true)
        
        navigationItem.setLeftBarButtonItems([
            UIBarButtonItem(
                image:  UIImage(systemName: "bell"),
                style: .plain,
                target: self,
                action: nil
            ),
        ], animated: true)
        
        navigationItem.title = "Direct Messages"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: MessagePreviewCell.reuseIdentifier, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationDelegate?.goToMessages()
    }
}
