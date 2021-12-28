//
//  RepostView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/27/21.
//

import UIKit


final class RepostView: UIView {
    
    
    private let headerView: PostHeaderView = {
        let view = PostHeaderView()
        view.profileImageHeight = 40
        view.subHeaderLabel.font = .systemFont(ofSize: 14)
        view.headerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        return view
    }()
    
    
    private let engagementBanner: EngagementBannerView = {
        let view = EngagementBannerView()
        view.textColor = .tertiaryTheme
        view.iconTintColor = .tertiaryTheme
        return view
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerView,
            chatBubbleStackView
        ])
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    

    private lazy var chatBubbleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            primaryLabelView,
            engagementBannerView
        ])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 5
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.borderColor = UIColor.systemBackground.cgColor
        stackView.cornerRadius(20, corners: [.topLeft, .bottomLeft, .bottomRight])
        stackView.layoutMargins.bottom = stackView.layer.borderWidth + stackView.layoutMargins.bottom
        return stackView
    }()
    
    
    let customViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.cornerRadius(20, corners: [.topRight, .topLeft, .bottomLeft])
        return view
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
    
    
    private let engagementBannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    
    required init() {
        super.init(frame: .zero)
        primaryLabelView.fill(with: primaryLabel, insets: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: -20))
        engagementBannerView.fill(with: engagementBanner, insets: UIEdgeInsets(top: 12, left: 20, bottom: -12, right: -20))
        fill(with: stackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        chatBubbleStackView.layer.borderColor = UIColor.systemBackground.cgColor
    }
    
    
    public func configure(with viewModel: PostViewModel) {
        primaryLabel.attributedStringForPost = viewModel.textContent
        headerView.configure(with: viewModel.postHeaderViewModel)
//        footerView.configure(with: viewModel.postFooterViewModel)
    }
    
}
