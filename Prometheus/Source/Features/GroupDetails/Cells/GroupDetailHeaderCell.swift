//
//  GroupDetailHeaderCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/13/21.
//

import UIKit

final class GroupDetailHeaderCell: UITableViewCell {
    
    private let view: GroupDetailsHeaderView = GroupDetailsHeaderView()
    
    init(reuseIdentifier: String) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.fill(with: view)
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

