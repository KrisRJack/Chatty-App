//
//  MessagePreviewView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/13/21.
//

import UIKit

final class MessagePreviewView: UIView {
    
    private var imageHeight: CGFloat { 50 }
    
    private lazy var primaryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeight.halfOf
        imageView.image = UIImage(named: "mockProfileImage")
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            displayNameLabel,
            usernameLabel,
            previewLabel
        ])
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.setCustomSpacing(8, after: usernameLabel)
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12h"
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .tertiaryLabel
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Kris Jackson"
        label.textColor = .tertiaryTheme
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@KrisRJack"
        label.textColor = .tertiaryTheme
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews([
            primaryImageView,
            infoStackView,
            dateLabel
        ], withConstraints: true)
        
        [primaryImageView.topAnchor.constraint(equalTo: topAnchor),
         primaryImageView.leftAnchor.constraint(equalTo: leftAnchor),
         primaryImageView.widthAnchor.constraint(equalToConstant: imageHeight),
         primaryImageView.heightAnchor.constraint(equalToConstant: imageHeight),
         primaryImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
         
         infoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
         infoStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
         infoStackView.leftAnchor.constraint(equalTo: primaryImageView.rightAnchor, constant: 8),
         
         dateLabel.rightAnchor.constraint(equalTo: rightAnchor),
         dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
         dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
         dateLabel.leftAnchor.constraint(equalTo: infoStackView.rightAnchor, constant: 2),
        ].activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
