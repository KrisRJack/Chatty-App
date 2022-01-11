//
//  PostTableViewCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import UIKit

final class PostCell: UITableViewCell {
    
    
    private let postView = PostView()
    
    
    public var engagementBannerNavigationDelegate: EngagementBannerNavigationDelegate? {
        get { postView.engagementBannerNavigationDelegate }
        set { postView.engagementBannerNavigationDelegate = newValue }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.fill(with: postView, insets: UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0), considerMargins: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postView.prepareForReuse()
    }
    
    
    public func configure(with viewModel: PostViewModel) {
        postView.configure(with: viewModel)
    }
    
    
}
