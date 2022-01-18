//
//  ComposePreviewHeaderCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/17/22.
//

import UIKit

final class ComposePreviewHeaderCell: UITableViewCell {
    
    private let headerView = ComposePreviewHeaderView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.fill(with: headerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
