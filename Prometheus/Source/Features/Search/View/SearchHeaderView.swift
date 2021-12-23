//
//  SearchHeaderView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/12/21.
//

import UIKit

final class SearchHeaderView: UIView {
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Find a community by typing the name, topic, or hashtag"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        fill(with: instructionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
