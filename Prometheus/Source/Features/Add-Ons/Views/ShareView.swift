//
//  ShareView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/2/22.
//

import UIKit

final class ShareView: UIView {
    
    
    // MARK: - Properties
    
    
    public var navigationDelegate: GroupFeedNavigationDelegate?
    
    
    private var viewModel: ShareViewModel!
    
    
    // MARK: - Views
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerView,
            engagementStackView
        ])
        stackView.spacing = 12
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
            primaryLabelView,
            footerView
        ])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 2
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.borderColor = UIColor.systemBackground.cgColor
        stackView.cornerRadius(20, corners: [.topLeft, .bottomLeft, .bottomRight])
        stackView.layoutMargins.bottom = stackView.layer.borderWidth + stackView.layoutMargins.bottom
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
    
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    
    private lazy var engagementBanner: EngagementBanner = {
        let view = EngagementBanner()
        view.delegate = self
        view.textColor = .tertiaryTheme
        view.iconTintColor = .tertiaryTheme
        return view
    }()
    
    
    // MARK: - Init
    
    
    required init(viewModel vm: ShareViewModel) {
        viewModel = vm
        super.init(frame: .zero)
        configure(with: viewModel)
        primaryLabelView.fill(with: primaryLabel, insets: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: -20))
        footerView.fill(with: engagementBanner, insets: UIEdgeInsets(top: 12, left: 20, bottom: -12, right: -20))
        fill(with: stackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        engagementStackView.layer.borderColor = UIColor.systemBackground.cgColor
    }
    
    
    // MARK: - Private
    
    
    private func configure(with viewModel: ShareViewModel) {
        primaryLabel.attributedStringForPost = viewModel.textContent
        headerView.configure(with: viewModel.headerViewModel)
    }
    
    
}


// MARK: - Engagement Banner Delegate


extension ShareView: EngagementBannerDelegate {
    
    
    func didTapLikeButton(_ engagementButton: EngagementButtonView) {
        print("Did tap like button")
    }
    
    
    func didTapShareButton(_ engagementButton: EngagementButtonView) {
        print("Did tap share button")
    }
    
    
    func didTapRepostButton(_ engagementButton: EngagementButtonView) {
        print("Did tap repost button")
    }
    
    
    func didTapCommentButton(_ engagementButton: EngagementButtonView) {
        print("Did tap comment button")
    }
    
    
}
