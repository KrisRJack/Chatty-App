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
    private var tableViewCells: [UITableViewCell] = []
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let cell = ComposeTextCell()
        cell.textViewDelegate = self
        cell.becomeFirstResponder()
        tableViewCells.append(cell)
        setUpViews()
    }
    
    
    convenience init(with viewModel: PostViewModel) {
        self.init()
        let view = PostView(with: viewModel)
        view.setProfileImageSize(to: 40)
        tableViewCells.append(ComposeContainerCell(containedView: view))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        removeKeyboardObservers()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setUpNavigationBar()
        setUpTableView()
        addKeyboardObservers()
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
        guard let time = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        UIView.animate(withDuration: time) {
            self.tableViewBottomAnchor.constant = -keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let time = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        UIView.animate(withDuration: time) {
            self.tableViewBottomAnchor.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    
    // MARK: - PRIVATE
    
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    private func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .done,
            target: nil,
            action: nil
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapLeftNavBarItem)
        )
        
        navigationItem.title = "Shake to Post 👋"
    }
    
    
    private func setUpViews() {
        view.addSubview(tableView, withConstraints: true)
        [tableView.topAnchor.constraint(equalTo: view.topAnchor),
         tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
         tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ].activate()
        tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        tableViewBottomAnchor.activate()
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
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: tableView.layoutMargins.top, right: 0)
        tableView.register(ComposeTextCell.self, forCellReuseIdentifier: ComposeTextCell.reuseIdentifier)
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
        return tableViewCells.count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCells[indexPath.item]
    }
    
    
}
