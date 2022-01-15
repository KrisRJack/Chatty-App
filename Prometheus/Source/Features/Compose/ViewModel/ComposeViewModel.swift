//
//  ComposeViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/13/22.
//

import Foundation

final class ComposeViewModel: NSObject {
    
    private var post: Post!
    
    public var numberOfSections: Int { 1 }
    public var numberOfRowsInSection: [Int : Int] { [0 : 1] }
    
    
    init(postModel: Post) {
        post = postModel
    }
    
}
