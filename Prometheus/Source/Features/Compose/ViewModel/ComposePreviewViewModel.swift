//
//  ComposePreviewViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/17/22.
//

import Foundation

final class ComposePreviewViewModel: NSObject {
    
    private var post: Post!
    
    public var numberOfSections: Int { 1 }
    public var viewModelForPost: PostViewModel!
    public var numberOfRowsInSection: [Int : Int] { [0: 1] }
    
    init(post: Post) {
        self.post = post
        self.viewModelForPost = PostViewModel(post: post)
        super.init()
    }
    
}
