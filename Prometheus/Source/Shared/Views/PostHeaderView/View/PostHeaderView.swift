//
//  PostHeaderView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import UIKit
import FirebaseStorageUI

class PostHeaderView: UIView {
    
    
    public var profileImageHeight: CGFloat {
        willSet {
            imageViewHeighAnchor?.constant = newValue
            imageView.cornerRadius(newValue.halfOf)
        }
    }
    
    
    private var imageViewHeighAnchor: NSLayoutConstraint?
    
    
    // MARK: - Views
    
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = profileImageHeight.halfOf
        return imageView
    }()
    
    
    
    public let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .tertiaryTheme
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    
    public let subHeaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    
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
    
    
    // MARK: Private Views
    
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            infoStackView
        ])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            subHeaderLabel
        ])
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    
    // MARK: - Init
    
    
    init() {
        profileImageHeight = 50
        super.init(frame: .zero)
        
        addSubviews([
            profileStackView,
            moreButton
        ], withConstraints: true)
        
        [profileStackView.topAnchor.constraint(equalTo: topAnchor),
         profileStackView.leftAnchor.constraint(equalTo: leftAnchor),
         profileStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
         
         moreButton.rightAnchor.constraint(equalTo: rightAnchor),
         moreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
         moreButton.leftAnchor.constraint(greaterThanOrEqualTo: profileStackView.rightAnchor)
        ].activate()
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).activate()
        imageViewHeighAnchor = imageView.widthAnchor.constraint(equalToConstant: profileImageHeight)
        imageViewHeighAnchor?.activate()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure View Model
    
    
    public func configure(with viewModel: PostHeaderViewModel) {
        headerLabel.text =  viewModel.headerString
        subHeaderLabel.text = viewModel.subHeaderString
        imageView.sd_setImage(
            with: viewModel.imageReference,
            placeholderImage: UIImage(systemName: "person.crop.circle.fill")
        )
    }
    
    
}

