//
//  GroupDetailsHeaderView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import UIKit

final class GroupDetailsHeaderView: UIView {
    
    private let profileImageView = GroupImageView(
        primaryImage: UIImage(named: "mockGroupPrimaryImage"),
        secondaryImage: UIImage(named: "mockGroupSecondaryImage")
    )
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            profileImageView,
            primaryLabel,
            secondaryLabel
        ])
        stackView.spacing = 20
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
        label.text = "NYC Running Group"
        label.font = .systemFont(ofSize: 26, weight: .black)
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .primaryTheme
        label.text = "nyc-running-group"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.baselineAdjustment = .none
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        fill(with: stackView, insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8), considerMargins: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
