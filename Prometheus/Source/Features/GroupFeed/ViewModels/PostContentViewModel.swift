//
//  PostContentViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/19/21.
//

import Foundation

final class PostContentViewModel: NSObject {
    
    private var post: Post!
    
    public var textContent: String {
        post.text
    }
    
    init(post model: Post) {
        post = model
    }
    
}
