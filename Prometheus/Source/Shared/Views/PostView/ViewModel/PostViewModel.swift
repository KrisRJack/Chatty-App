//
//  PostViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/17/21.
//

import RxSwift
import FirebaseFirestore

final class PostViewModel: PostViewModelType {
    
    
    public var post: PostModelType!
    public var rePostViewModel: PostViewModelType?
    
    
    public var text: String? {
        post.text
    }
    
    
    public var doesContainCustomView: Bool {
        customViewType != CustomCellType.none
    }
    
    
    public var isTextContentEmpty: Bool {
        text?.isEmpty ?? true
    }
    
    
    public var customViewType: CustomCellType {
        post.cellType
    }
    
    
    public var postHeaderViewModel: PostHeaderViewModel!
    public var postFooterViewModel: EngagementBannerViewModel!
    
    
    var comments: [Comment]!
    var newestCommentDocument: QueryDocumentSnapshot?
    var oldestCommentDocument: QueryDocumentSnapshot?
    
    
    init(post model: PostModelType) {
        post = model
        if let repost = model.repost {
            rePostViewModel = PostViewModel(post: repost)
        }
        postHeaderViewModel = PostHeaderViewModel(post: post)
        postFooterViewModel = EngagementBannerViewModel(post: post, postViewModel: self)
    }
    
    
    public func fetchNewerCommentBatch()  {
        
    }
    
    
    public func fetchInitialCommentBatch() {
        
    }
    
    
    public func fetchNextCommentBatch() {
    
    
    }
    
}
