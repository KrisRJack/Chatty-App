//
//  ShareViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/2/22.
//

import Foundation

final class ShareViewModel {
    
    public var textContent: String? { post.text }
    public var headerViewModel: PostHeaderViewModel!
    public var footerViewModel: EngagementBannerViewModel!
    
    private var post: Post!
    
    init(post model: Post) {
        post = model
        headerViewModel = PostHeaderViewModel(post: model)
        footerViewModel = EngagementBannerViewModel(post: model)
    }
    
}
