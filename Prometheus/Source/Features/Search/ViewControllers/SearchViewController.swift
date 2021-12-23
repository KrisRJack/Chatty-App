//
//  SearchViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/5/21.
//

import UIKit

protocol SearchNavigationDelegate {
    func goToLastViewController()
}

final class SearchViewController: UITableViewController {
    
    public var navigationDelegate: SearchNavigationDelegate?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.tintColor = .tertiaryTheme
        searchBar.barTintColor = .tertiaryTheme
        searchBar.placeholder = "Find a Community"
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
        searchBar.becomeFirstResponder()
    }
    
    private func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image:  UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.titleView = searchBar
    }
    
    @objc private func dismissKeyboard() {
        searchBar.text = nil
        navigationDelegate?.goToLastViewController()
    }
    
    
    // MARK: - Table View Data Source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SearchHeaderCell(reuseIdentifier: SearchHeaderCell.reuseIdentifier)
    }
    
}


// MARK: - UISearchBarDelegate


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        navigationDelegate?.goToLastViewController()
    }
    
}
