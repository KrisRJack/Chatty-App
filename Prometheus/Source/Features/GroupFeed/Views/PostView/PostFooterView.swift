//
//  PostFooterView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

final class PostFooterView: UIView {
    
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
    
    private let likeButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setTextColor(.tertiaryTheme, forState: .normal)
        view.setImageColor(.systemPink, forState: .selected)
        view.setImageColor(.tertiaryTheme, forState: .normal)
        view.setImage(withSystemName: "heart", forState: .normal)
        view.setImage(withSystemName: "heart.fill", forState: .selected)
        view.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return view
    }()
    
    private let repostButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setTextColor(.tertiaryTheme, forState: .normal)
        view.setImageColor(.tertiaryTheme, forState: .normal)
        view.setImageColor(.systemGreen, forState: .selected)
        view.setImage(withSystemName: "arrowshape.turn.up.right", forState: .normal)
        view.setImage(withSystemName: "arrowshape.turn.up.right.fill", forState: .selected)
        view.addTarget(self, action: #selector(repostButtonPressed), for: .touchUpInside)
        return view
    }()
    
    private let commentButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setTextColor(.tertiaryTheme, forState: .normal)
        view.setImageColor(.tertiaryTheme, forState: .normal)
        view.setImageColor(.primaryTheme, forState: .selected)
        view.setImage(withSystemName: "bubble.right", forState: .normal)
        view.setImage(withSystemName: "bubble.right.fill", forState: .selected)
        view.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
        return view
    }()
    
    private let shareButton: EngagementButtonView = {
        let view = EngagementButtonView()
        view.setTextColor(.tertiaryTheme, forState: .normal)
        view.setImageColor(.tertiaryTheme, forState: .normal)
        view.setImage(withSystemName: "square.and.arrow.up", forState: .normal)
        view.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        likeButton.text = "8K"
        repostButton.text = "30"
        commentButton.text = "56"
        fill(with: stackView, insets: UIEdgeInsets(top: 12, left: 20, bottom: -12, right: -20))
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
    
}
