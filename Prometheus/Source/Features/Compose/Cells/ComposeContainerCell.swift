//
//  ComposeContainerCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/9/22.
//

import UIKit

final class ComposeContainerCell: UITableViewCell {
    
    private let containerView = UIView()
    
    init(containedView view: UIView) {
        super.init(style: .default, reuseIdentifier: ComposeContainerCell.reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.fill(with: view, insets: UIEdgeInsets(top: 20, left: 64, bottom: 8, right: 0), considerMargins: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addShadow() {
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 1
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.softShadow.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}
