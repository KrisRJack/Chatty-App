//
//  PostViewModelType.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/28/22.
//

import RxSwift
import Foundation
import FirebaseFirestore

protocol PostViewModelType {
    
    
    var post: PostModelType! { get }
    var rePostViewModel: PostViewModelType? { get }
    
    
    var text: String? { get }
    var isTextContentEmpty: Bool { get }
    var doesContainCustomView: Bool { get }
    var customViewType: CustomCellType { get }

    
    var postHeaderViewModel: PostHeaderViewModel { get }
    var postFooterViewModel: EngagementBannerViewModel { get }
    
    
    var comments: [Comment]! { get }
    var newestCommentDocument: QueryDocumentSnapshot? { get }
    var oldestCommentDocument: QueryDocumentSnapshot? { get }
    
    
    init(post model: PostModelType)
    
    
    func fetchNewerCommentBatch()
    func fetchInitialCommentBatch()
    func fetchNextCommentBatch() 
    
    
}
