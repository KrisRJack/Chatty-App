//
//  ShareView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/2/22.
//

import UIKit

protocol ShareViewDelegate {
    func didTap(for viewModel: PostViewModelType)
}

final class ShareView: UIView {
    
    
    // MARK: - Properties
    
    public var delegate: ShareViewDelegate?
    private var viewModel: PostViewModelType!
    
    
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
    
    
    required init(viewModel vm: PostViewModelType) {
        viewModel = vm
        super.init(frame: .zero)
        configure(with: viewModel)
        addTapGesture()
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
    
    
    // MARK: - Add Tap Gesture
    
    
    public func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEngagementStackView))
        engagementStackView.addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func didTapEngagementStackView() {
        delegate?.didTap(for: viewModel)
    }
    
    
    // MARK: - Private
    
    
    private func configure(with viewModel: PostViewModelType) {
        primaryLabel.attributedStringForPost = viewModel.text
        headerView.configure(with: viewModel.postHeaderViewModel)
        if viewModel.doesContainCustomView {
            engagementStackView.addArrangedSubview(secondaryLabel)
        }
    }
    
    
}
