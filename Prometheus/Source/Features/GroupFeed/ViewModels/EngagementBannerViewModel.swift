//
//  EngagementBannerViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/19/21.
//

import FirebaseAuth
import FirebaseFirestore

final class EngagementBannerViewModel: NSObject {
    
    
    enum ButtonType {
        case like
        case repost
        case comment
    }
    
    
    public var viewModelForPost: PostViewModel!
    
    
    public var likeCountStringValue: ((String) -> Void)?
    public var repostCountStringValue: ((String) -> Void)?
    public var commentCountStringValue: ((String) -> Void)?
    
    
    public var addObserverToLikeButtonSelectedState: (() -> Bool)?
    public var addObserverToRepostButtonSelectedState: (() -> Bool)?
    public var addObserverToCommentButtonSelectedState: (() -> Bool)?
    
    
    public var likeButtonSelectedState: ((_ isSelected: Bool) -> Void)?
    public var repostButtonSelectedState: ((_ isSelected: Bool) -> Void)?
    public var commentButtonSelectedState: ((_ isSelected: Bool) -> Void)?
    public var presentErrorMessage: ((_ errorMessage: String) -> Void)?
    
    
    private var post: Post!
    private var likeButtonIsSelected: Bool { addObserverToLikeButtonSelectedState?() ?? false }
    private var repostButtonIsSelected: Bool { addObserverToRepostButtonSelectedState?() ?? false }
    private var commentButtonIsSelected: Bool { addObserverToCommentButtonSelectedState?() ?? false }
    
    
    init(post model: Post) {
        post = model
        viewModelForPost = PostViewModel(post: model)
    }
    
    
    public func loadInitialData() {
        loadSelectedState(forButton: .like)
        loadSelectedState(forButton: .repost)
        loadSelectedState(forButton: .comment)
        likeCountStringValue?(post.numOfLikes.roundedWithAbbreviations)
        repostCountStringValue?(post.numOfReposts.roundedWithAbbreviations)
        commentCountStringValue?(post.numOfComments.roundedWithAbbreviations)
    }
    
    
    public func loadSelectedState(forButton button: ButtonType) {
        let reference = collectionReference(forButton: button)
        
        guard let currentUser = Auth.auth().currentUser else {
            self.presentErrorMessage?("User does not exist. Please sign into an account to continue.")
            return
        }
        
        reference.document(currentUser.uid).getDocument { snapshot, error in
            if let error = error {
                self.presentErrorMessage?(error.localizedDescription)
                return
            }
            self.sendButtonState(button)?(snapshot?.exists ?? false)
        }
    }
    
    
    public func likeButtonTapped() {
        
        guard let currentUser = Auth.auth().currentUser else {
            self.presentErrorMessage?("User does not exist. Please sign into an account to continue.")
            return
        }
        
        if likeButtonIsSelected {
            
            post.likesCollection.document(currentUser.uid).delete { error in
                if error != nil {
                    self.presentErrorMessage?("There was an error unliking this post. It could be because the user has deleted it.")
                    return
                }
                self.post.numOfLikes -= 1
                self.likeButtonSelectedState?(!self.likeButtonIsSelected)
                self.likeCountStringValue?(self.post.numOfLikes.roundedWithAbbreviations)
                self.post.reference.setData([DatabaseKeys.Post.numOfLikes.rawValue: FieldValue.increment(Int64(-1))], merge: true)
            }
            
        } else {
            
            post.likesCollection.document(currentUser.uid).setData(LikeModel(
                
                id: LikeModel.ID(rawValue: currentUser.uid),
                userID: User.ID(rawValue: currentUser.uid),
                postID: post.id,
                groupID: post.groupID,
                timestamp: Date()
    
            ).asDictionary, merge: true) { error in
                if error != nil {
                    self.presentErrorMessage?("There was an error liking this post. It could be because the user has deleted it.")
                    return
                }
                self.post.numOfLikes += 1
                self.likeButtonSelectedState?(!self.likeButtonIsSelected)
                self.likeCountStringValue?(self.post.numOfLikes.roundedWithAbbreviations)
                self.post.reference.setData([DatabaseKeys.Post.numOfLikes.rawValue: FieldValue.increment(Int64(1))], merge: true)
            }
            
        }
        
    }
    
    
    // MARK: - PRIVATE
    
    
    private func collectionReference(forButton button: ButtonType) -> CollectionReference {
        switch button {
        case .like:
            return post.likesCollection
        case .repost:
            return post.repostsCollection
        case .comment:
            return post.commentsCollection
        }
    }
    
    
    private func sendButtonState(_ button: ButtonType) -> ((_ isSelected: Bool) -> Void)? {
        switch button {
        case .like:
            return likeButtonSelectedState
        case .repost:
            return repostButtonSelectedState
        case .comment:
            return commentButtonSelectedState
        }
    }
    
    
}
