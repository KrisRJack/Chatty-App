//
//  ShareView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/2/22.
//

import UIKit

final class ShareView: UIView {
    
    
    // MARK: - Properties
    
    private var viewModel: PostViewModel!
    
    
    // MARK: - Views
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerView,
            engagementStackView
        ])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    
    private let headerView: PostHeaderView = {
        let view = PostHeaderView()
        view.profileImageHeight = 40
        view.subHeaderLabel.font = .systemFont(ofSize: 14)
        view.headerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        return view
    }()

    
    private lazy var engagementStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            primaryLabel
        ])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .systemBackground
        stackView.cornerRadius(20, corners: [.topLeft, .bottomLeft, .bottomRight])
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    
    private let primaryLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .tertiaryTheme
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let secondaryLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "•••"
        label.numberOfLines = 0
        label.textColor = .tertiaryTheme
        label.font = .preferredFont(forTextStyle: .body, weight: .black)
        return label
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    
    // MARK: - Init
    
    
    required init(viewModel vm: PostViewModel) {
        viewModel = vm
        super.init(frame: .zero)
        configure(with: viewModel)
        fill(with: stackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        engagementStackView.layer.borderColor = UIColor.systemBackground.cgColor
    }
    
    
    // MARK: - Set Profile Image Height
    
    
    public func setProfileImageSize(to size: CGFloat) {
        headerView.profileImageHeight = size
    }
    
    
    // MARK: - Private
    
    
    private func configure(with viewModel: PostViewModel) {
        primaryLabel.attributedStringForPost = viewModel.textContent
        headerView.configure(with: viewModel.postHeaderViewModel)
        if viewModel.showMore {
            engagementStackView.addArrangedSubview(secondaryLabel)
        }
    }
    
    
}
