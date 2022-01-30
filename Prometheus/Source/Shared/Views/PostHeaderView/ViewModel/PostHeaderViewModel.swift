//
//  PostHeaderViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/19/21.
//

import Foundation
import FirebaseStorage

final class PostHeaderViewModel: NSObject {
    
    private var post: PostModelType!
    
    public var headerString: String {
        post.firstName + " " + post.lastName
    }
    
    public var subHeaderString: String {
        post.username + " • " + post.timestamp.getElapsedInterval()
    }
    
    public var imageReference: StorageReference {
        post.referenceToProfileImage
    }
    
    init(post model: PostModelType) {
        post = model
    }
    
}
