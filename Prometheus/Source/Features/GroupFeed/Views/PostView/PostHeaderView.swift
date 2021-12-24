//
//  PostHeaderView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import UIKit
import FirebaseStorageUI

class PostHeaderView: UIView {
    
    private var profileImageHeight: CGFloat { 50 }
    
    // MARK: Profile Stack View
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            profileImageView,
            infoStackView
        ])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mockProfileImage"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = profileImageHeight.halfOf
        return imageView
    }()
    
    
    // MARK: Info Stack View
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            displayNameLabel,
            usernameLabel
        ])
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .tertiaryTheme
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    
    // MARK: More Button
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(
            systemName: "ellipsis",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16))
        ), for: .normal)
        button.tintColor = .tertiaryLabel
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    // MARK: - Init
    
    
    init() {
        super.init(frame: .zero)
        
        displayNameLabel.text = "Kris Jackson"
        usernameLabel.text = "KrisRJack • 12h"
        
        addSubviews([
            profileStackView,
            moreButton
        ], withConstraints: true)
        
        [profileStackView.topAnchor.constraint(equalTo: topAnchor),
         profileStackView.leftAnchor.constraint(equalTo: leftAnchor),
         profileStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
         
         profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
         profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: profileImageHeight),
         
         moreButton.rightAnchor.constraint(equalTo: rightAnchor),
         moreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
         moreButton.leftAnchor.constraint(greaterThanOrEqualTo: profileStackView.rightAnchor)
        ].activate()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

