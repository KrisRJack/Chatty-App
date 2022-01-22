//
//  PostDetailViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/21/22.
//

import UIKit


final class PostDetailViewController: UIViewController {
    
    
    private var viewModel: PostViewModel!
    
    
    // MARK: - Init
    
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}
