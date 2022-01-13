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


final class ComposePreviewViewController: UITableViewController {
    
    public var navigationDelegate: ComposePreviewNavigationDelegate?
    
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
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
    
}
