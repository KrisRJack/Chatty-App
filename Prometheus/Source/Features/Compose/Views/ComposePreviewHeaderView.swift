//
//  ComposePreviewHeaderView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/17/22.
//

import UIKit


final class ComposePreviewHeaderView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            primaryLabel,
            secondaryLabel
        ])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.setCustomSpacing(5, after: primaryLabel)
        return stackView
    }()
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .tertiaryTheme
        label.text = "Ready to Post?"
        label.font = .preferredFont(forTextStyle: .title3, weight: .black)
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.baselineAdjustment = .none
        label.textColor = .secondaryLabel
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "This is how your post will appear for others.\nAre you sure you're ready to send?"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        fill(with: stackView, insets: UIEdgeInsets(top: 8, left: 20, bottom: -20, right: -20), considerMargins: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
