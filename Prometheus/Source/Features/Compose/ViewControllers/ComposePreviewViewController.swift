//
//  ComposePreviewViewController.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/12/22.
//

import UIKit

final class ComposePreviewViewController: UIViewController {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
}
