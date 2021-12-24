//
//  PostTableViewCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import UIKit

final class PostCell: UITableViewCell {
    
    private let postTextView = PostTextView()
    
    
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
        let headerView = PostHeaderView()
        return headerView
    }()
    
    
    private lazy var engagementStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            containerView,
            footerView
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 3
        stackView.layoutMargins = UIEdgeInsets(
            top: stackView.layoutMargins.top,
            left: stackView.layoutMargins.left,
            bottom: stackView.layoutMargins.bottom + stackView.layer.borderWidth,
            right: stackView.layoutMargins.right
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
        return stackView
    }()
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    
    private let footerView: PostFooterView = {
        let footerView = PostFooterView()
        return footerView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.fill(with: postTextView)
        contentView.fill(with: stackView, insets: UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0), considerMargins: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        engagementStackView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
    
    
}
