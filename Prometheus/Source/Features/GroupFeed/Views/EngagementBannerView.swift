//
//  EngagementBannerView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

final class EngagementBannerView: UIView {
    
    
    public var viewModel: EngagementBannerViewModel?
    
    
    public var textColor: UIColor {
        willSet {
            likeButton.setTextColor(newValue, forState: .normal)
            repostButton.setTextColor(newValue, forState: .normal)
            commentButton.setTextColor(newValue, forState: .normal)
            shareButton.setTextColor(newValue, forState: .normal)
        }
    }
    
    
    public var iconTintColor: UIColor {
        willSet {
            likeButton.setImageColor(newValue, forState: .normal)
            repostButton.setImageColor(newValue, forState: .normal)
            commentButton.setImageColor(newValue, forState: .normal)
            shareButton.setImageColor(newValue, forState: .normal)
        }
    }
    
    public let likeButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImageColor(.systemPink, forState: .selected)
        view.setImage(withSystemName: "heart", forState: .normal)
        view.setImage(withSystemName: "heart.fill", forState: .selected)
        view.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return view
    }()
    
    public let repostButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImageColor(.systemGreen, forState: .selected)
        view.setImage(withSystemName: "arrowshape.turn.up.right", forState: .normal)
        view.setImage(withSystemName: "arrowshape.turn.up.right.fill", forState: .selected)
        view.addTarget(self, action: #selector(repostButtonPressed), for: .touchUpInside)
        return view
    }()
    
    public let commentButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImageColor(.primaryTheme, forState: .selected)
        view.setImage(withSystemName: "bubble.right", forState: .normal)
        view.setImage(withSystemName: "bubble.right.fill", forState: .selected)
        view.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
        return view
    }()
    
    public let shareButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setImage(withSystemName: "square.and.arrow.up", forState: .normal)
        view.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            commentButton,
            repostButton,
            likeButton,
            shareButton,
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init() {
        textColor = .tertiaryTheme
        iconTintColor = .tertiaryTheme
        super.init(frame: .zero)
        
        likeButton.text = "8K"
        repostButton.text = "30"
        commentButton.text = "56"
        
        backgroundColor = .clear
        fill(with: stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Objective C Functions
    
    
    @objc private func likeButtonPressed() {
        likeButton.isSelected = !likeButton.isSelected
    }
    
    
    @objc private func repostButtonPressed() {
        repostButton.isSelected = !repostButton.isSelected
    }
    
    
    @objc private func commentButtonPressed() {
        commentButton.isSelected = !commentButton.isSelected
    }
    
    
    @objc private func shareButtonPressed() {
        // TODO: Implement
    }
    
    
    // MARK: - Configure View Model
    
    
    public func configure(with viewModel: EngagementBannerViewModel) {
        self.viewModel = viewModel

        viewModel.likeCountStringValue = ({ self.likeButton.text = $0 })
        viewModel.repostCountStringValue = ({ self.repostButton.text = $0 })
        viewModel.commentCountStringValue = ({ self.commentButton.text = $0 })

        viewModel.likeButtonSelectedState = ({ self.likeButton.isSelected = $0 })
        viewModel.repostButtonSelectedState = ({ self.repostButton.isSelected = $0 })
        viewModel.commentButtonSelectedState = ({ self.commentButton.isSelected = $0 })

        viewModel.addObserverToLikeButtonSelectedState = ({ self.likeButton.isSelected })
        viewModel.addObserverToRepostButtonSelectedState = ({ self.repostButton.isSelected })
        viewModel.addObserverToCommentButtonSelectedState = ({ self.commentButton.isSelected })

        viewModel.loadInitialData()
    }
}
