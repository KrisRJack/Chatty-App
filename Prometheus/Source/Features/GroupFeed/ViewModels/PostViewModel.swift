//
//  PostViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/17/21.
//

import FirebaseFirestore

final class PostViewModel: NSObject {
    
    private var post: Post!
    
    public var postHeaderViewModel: PostHeaderViewModel {
        PostHeaderViewModel(post: post)
    }
    
    public var postContentViewModel: PostContentViewModel {
        PostContentViewModel(post: post)
    }
    
    public var postFooterViewModel: PostFooterViewModel {
        PostFooterViewModel(post: post)
    }
    
    init(post model: Post) {
        post = model
    }
    
}
