//
//  ComposeViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/9/21.
//

import UIKit

protocol ComposeNavigationDelegate {
    func dismiss()
}

final class ComposeViewController: UIViewController {
    
    public let tableView: UITableView = UITableView()
    public var navigationDelegate: ComposeNavigationDelegate?
    private var tableViewBottomAnchor: NSLayoutConstraint!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(tableView, withConstraints: true)
        [tableView.topAnchor.constraint(equalTo: view.topAnchor),
         tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
         tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ].activate()
        
        tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        tableViewBottomAnchor.activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        setUpNavigationBar()
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: tableView.layoutMargins.top, right: 0)
        tableView.register(ComposeTextCell.self, forCellReuseIdentifier: ComposeTextCell.reuseIdentifier)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            Vibration.vibrate(with: .success)
            navigationDelegate?.dismiss()
        }
    }
    
    // MARK: - Objective-C Function
    
    
    @objc private func didTapLeftNavBarItem() {
        navigationDelegate?.dismiss()
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let _ = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        tableViewBottomAnchor.constant = -keyboardFrame.height
    }
    
    
    // MARK: - PRIVATE
    
    
    private func setUpNavigationBar() {
        navigationItem.title = "Shake to Post 👋"
        
        navigationItem.rightBarButtonItems = [
            
            UIBarButtonItem(
                image: UIImage(systemName: "line.3.horizontal"),
                style: .done,
                target: nil,
                action: nil
            ),
            
        ]
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(didTapLeftNavBarItem)
            ),
        ]
    }
}


// MARK: - UITextViewDelegate


extension ComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}


// MARK: - UITableViewDataSource


extension ComposeViewController: UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ComposeTextCell(reuseIdentifier: ComposeTextCell.reuseIdentifier)
        cell.textViewDelegate = self
        cell.becomeFirstResponder()
        return cell
    }
    
}
