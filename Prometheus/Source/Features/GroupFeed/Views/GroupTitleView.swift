//
//  GroupTitleView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit

class GroupTitleView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel
        ])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .tertiaryTheme
        label.text = "iOS Development Group"
        label.font = .systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    private lazy var membersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            membersLabel
        ])
        stackView.spacing = 3
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(
            systemName: "person.3",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14))
        ))
        imageView.tintColor = .primaryTheme
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let membersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .tertiaryTheme
        label.text = "12K Members"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        fill(with: stackView, insets: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
