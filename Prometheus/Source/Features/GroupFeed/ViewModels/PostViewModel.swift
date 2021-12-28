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
    

    public var textContent: String {
        post.text
    }
    
    
    public var postHeaderViewModel: PostHeaderViewModel {
        PostHeaderViewModel(post: post)
    }
    
    
    public var postFooterViewModel: EngagementBannerViewModel {
        EngagementBannerViewModel(post: post)
    }
    
    
    init(post model: Post) {
        post = model
        super.init()
    }
    
    
    public func beginLoadingContentIfNeeded() {
        post.repostedReference?.getDocument(completion: { snapshot, error in
            if let _ = error { return }
            guard let snapshot = snapshot else { return }
            if let data = snapshot.data() {
                self.rePostViewModel = PostViewModel(post: Post(withData: data))
                guard let indexPath = self.indexPath else { return }
                self.reloadAt?(indexPath)
            }
        })
    }
    
}
