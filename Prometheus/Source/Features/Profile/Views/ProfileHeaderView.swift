//
//  ProfileHeaderView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/7/21.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    private let profileImageView = ProfileImageView(
        primaryImage: UIImage(named: "mockProfileImage")
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
        label.text = "Kris Jackson"
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .primaryTheme
        label.text = "@KrisRJack"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.baselineAdjustment = .none
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(stackView, withConstraints: true)
        [stackView.topAnchor.constraint(equalTo: topAnchor),
         stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 8),
         stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -8),
         stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ].activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
