//
//  PostViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/17/21.
//

import FirebaseFirestore

final class PostViewModel: NSObject {
    
    
    public var post: Post!
    public var indexPath: IndexPath?
    public var rePostViewModel: PostViewModel?
    public var reloadAt: ((_ indexPath: IndexPath) -> Void)?
    
    
    public var showMore: Bool {
        post.cellType != CustomCellType.none
    }
    
    public var textContent: String? {
        post.text
    }
    
    
    public var isTextContentEmpty: Bool {
        textContent?.isEmpty ?? true
    }
    
    
    public var postHeaderViewModel: PostHeaderViewModel {
        PostHeaderViewModel(post: post)
    }
    
    
    public var postFooterViewModel: EngagementBannerViewModel {
        EngagementBannerViewModel(post: post, postViewModel: self)
    }
    
    
    init(post model: Post) {
        post = model
        if let repost = model.repost {
            rePostViewModel = PostViewModel(post: repost)
        }
        super.init()
    }
    
}
