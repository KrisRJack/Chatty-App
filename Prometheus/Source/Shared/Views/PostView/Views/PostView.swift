//
//  PostView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/9/22.
//


import UIKit

final class PostView: UIView {
    
    
    public var engagementBannerNavigationDelegate: EngagementBannerNavigationDelegate? {
        get { engagementBanner.navigationDelegate }
        set { engagementBanner.navigationDelegate = newValue }
    }
    
    
    // MARK: - Views
    
    
    private let headerView: PostHeaderView = {
        let view = PostHeaderView()
        return view
    }()
    
    
    private lazy var engagementBanner: EngagementBanner = {
        let view = EngagementBanner()
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
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .secondarySystemBackground
        stackView.cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
        stackView.layoutMargins.bottom = stackView.layer.borderWidth + stackView.layoutMargins.bottom
        stackView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
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
    
    
    private let engagementBannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    
    // MARK: - Init
    
    
    init() {
        super.init(frame: .zero)
        addSubviewsToView()
        resetArrangedSubviews()
        backgroundColor = .clear
    }
    
    
    convenience init(with viewModel: PostViewModel) {
        self.init()
        configure(with: viewModel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        chatBubbleStackView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
    
    
    // MARK: - Public
    
    
    public func prepareForReuse() {
        resetArrangedSubviews()
    }
    
    
    public func setProfileImageSize(to size: CGFloat) {
        headerView.profileImageHeight = size
    }
    
    
    public func configure(with viewModel: PostViewModel) {
        primaryLabel.attributedStringForPost = viewModel.textContent
        headerView.configure(with: viewModel.postHeaderViewModel)
        engagementBanner.configure(with: viewModel.postFooterViewModel)
        addCustomViewIfNeeded(with: viewModel.rePostViewModel)
    }
    
    
    // MARK: - Private
    
    
    private func resetArrangedSubviews() {
        chatBubbleStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        chatBubbleStackView.addArrangedSubview(primaryLabelView)
        chatBubbleStackView.addArrangedSubview(engagementBannerView)
    }
    
    
    private func addSubviewsToView() {
        primaryLabelView.fill(with: primaryLabel, insets: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: -20))
        engagementBannerView.fill(with: engagementBanner, insets: UIEdgeInsets(top: 12, left: 20, bottom: -12, right: -20))
        fill(with: stackView)
    }
    
    
    private func addCustomViewIfNeeded(with customViewModel: PostViewModel?) {
        let customViewContainer: UIView = UIView()
        customViewContainer.backgroundColor = .clear
        customViewContainer.cornerRadius(20, corners: [.topRight, .topLeft, .bottomLeft])
        if let customViewModel = customViewModel {
            let repostedView = ShareView(viewModel: customViewModel)
            customViewContainer.fill(with: repostedView, insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20))
            chatBubbleStackView.insertArrangedSubview(customViewContainer, at: 1)
        }
    }
    
    
}
