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
    
    private var post: PostModelType!
    
    init(post model: PostModelType, postViewModel: PostViewModelType) {
        post = model
        headerViewModel = PostHeaderViewModel(post: model)
        footerViewModel = EngagementBannerViewModel(post: model, postViewModel: postViewModel)
    }
    
}
