//
//  PostViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/17/21.
//

import FirebaseFirestore

final class PostViewModel: NSObject {
    
    
    private var post: Post!
    
    public var indexPath: IndexPath?
    public var rePostViewModel: PostViewModel?
    public var reloadAt: ((_ indexPath: IndexPath) -> Void)?
    

    public var textContent: String? {
        post.text
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
    
    
    public func fetchContentIfNeeded(completion: ((_ error: Error?) -> Void)? = nil) {
        guard let reference = post.repostedReference else {
            completion?(nil)
            return
        }
        reference.getDocument(completion: { snapshot, error in
            if let _ = error {
                completion?(error)
                return
            }
            guard let snapshot = snapshot else {
                completion?(nil)
                return
            }
            if let data = snapshot.data() {
                self.rePostViewModel = PostViewModel(post: Post(withData: data))
                completion?(nil)
            }
        })
    }
    
}
