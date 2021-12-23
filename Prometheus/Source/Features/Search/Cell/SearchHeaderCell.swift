//
//  SearchHeaderCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/11/21.
//

import UIKit

final class SearchHeaderCell: UITableViewCell {
    
    private let view = SearchHeaderView()
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        fill(with: view, considerMargins: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
