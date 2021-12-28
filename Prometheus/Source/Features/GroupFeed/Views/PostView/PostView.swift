//
//  PostView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/24/21.
//

import UIKit


final class PostView: UIView {
    
    
    private let headerView = PostHeaderView()
    private let engagementBanner = EngagementBannerView()
    
    
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
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .secondarySystemBackground
        stackView.cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
        stackView.layoutMargins.bottom = stackView.layer.borderWidth + stackView.layoutMargins.bottom
        stackView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
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
        view.backgroundColor = .systemBackground
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
        chatBubbleStackView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
    
    
    private func setUpStack(withCustomView customView: UIView?) {
        if let customView = customView {
            customViewContainer.fill(with: customView, insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20))
            chatBubbleStackView.insertArrangedSubview(customViewContainer, at: 1)
        } else {
            customViewContainer.removeFromSuperview()
            chatBubbleStackView.removeArrangedSubview(customViewContainer)
            customViewContainer.subviews.forEach({ $0.removeFromSuperview() })
        }
    }
    
    
    public func configure(with viewModel: PostViewModel) {
        primaryLabel.attributedStringForPost = viewModel.textContent
        headerView.configure(with: viewModel.postHeaderViewModel)
//        footerView.configure(with: viewModel.postFooterViewModel)
//
        var customView: UIView?
        if let rePostViewModel = viewModel.rePostViewModel {
            let repostedView = RepostView()
            repostedView.configure(with: rePostViewModel)
            customView = repostedView
        }
        setUpStack(withCustomView: customView)
    }
    
}
