//
//  EngagementBannerViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/19/21.
//

import RxCocoa
import FirebaseAuth
import FirebaseFirestore

final class EngagementBannerViewModel: NSObject {
    
    
    enum ButtonType {
        case like
        case repost
        case comment
    }
    
    
    private var post: PostModelType!
    
    
    public var viewModelForPost: PostViewModelType!
    public var didLoadData: BehaviorRelay<Bool> = .init(value: false)
    public var presentErrorMessage: PublishRelay<String> = PublishRelay<String>()
    
    
    public var numberOfLikes: BehaviorRelay<Int> { post.numOfLikes }
    public var numberOfReposts: BehaviorRelay<Int> { post.numOfReposts }
    public var numberOfComments: BehaviorRelay<Int> { post.numOfComments }
    
    
    public var likeButtonIsSelected: BehaviorRelay<Bool> = .init(value: false)
    public var repostButtonIsSelected: BehaviorRelay<Bool> = .init(value: false)
    public var commentButtonIsSelected: BehaviorRelay<Bool> = .init(value: false)
    
    
    init(post model: PostModelType) {
        post = model
        viewModelForPost = PostViewModel(post: model)
    }
    
    init(post model: PostModelType, postViewModel: PostViewModelType) {
        post = model
        viewModelForPost = postViewModel
    }
    
    
    public func loadInitialData() {
        loadSelectedState(forButton: .like)
        loadSelectedState(forButton: .repost)
        loadSelectedState(forButton: .comment)
        didLoadData.accept(true)
    }
    
    
    public func loadSelectedState(forButton button: ButtonType) {
        let reference = collectionReference(forButton: button)
        
        guard let currentUser = Auth.auth().currentUser else {
            self.presentErrorMessage.accept("User does not exist. Please sign into an account to continue.")
            return
        }
        
        reference.document(currentUser.uid).getDocument { snapshot, error in
            if let error = error {
                self.presentErrorMessage.accept(error.localizedDescription)
                return
            }
            self.sendButtonState(button).accept(snapshot?.exists ?? false)
        }
    }
    
    
    public func likeButtonTapped() {
        
        guard let currentUser = Auth.auth().currentUser else {
            self.presentErrorMessage.accept("User does not exist. Please sign into an account to continue.")
            return
        }
        
        if likeButtonIsSelected.value {
            
            post.collectionOfLikes.document(currentUser.uid).delete { error in
                if error != nil {
                    self.presentErrorMessage.accept("There was an error unliking this post. It could be because the user has deleted it.")
                    return
                }
                self.post.numOfLikes.accept(self.post.numOfLikes.value - 1)
                self.likeButtonIsSelected.accept(!self.likeButtonIsSelected.value)
                self.post.reference.setData([DatabaseKeys.Post.numOfLikes.rawValue: FieldValue.increment(Int64(-1))], merge: true)
            }
            
        } else {
            
            post.collectionOfLikes.document(currentUser.uid).setData(LikeModel(
                
                id: LikeModel.ID(rawValue: currentUser.uid),
                userID: User.ID(rawValue: currentUser.uid),
                postID: post.id,
                groupID: post.groupID,
                timestamp: Date()
    
            ).asDictionary, merge: true) { error in
                if error != nil {
                    self.presentErrorMessage.accept("There was an error liking this post. It could be because the user has deleted it.")
                    return
                }
                self.post.numOfLikes.accept(self.post.numOfLikes.value + 1)
                self.likeButtonIsSelected.accept(!self.likeButtonIsSelected.value)
                self.post.reference.setData([DatabaseKeys.Post.numOfLikes.rawValue: FieldValue.increment(Int64(1))], merge: true)
            }
            
        }
        
    }
    
    
    // MARK: - PRIVATE
    
    
    private func collectionReference(forButton button: ButtonType) -> CollectionReference {
        switch button {
        case .like:
            return post.collectionOfLikes
        case .repost:
            return post.collectionOfReposts
        case .comment:
            return post.collectionOfComments
        }
    }
    
    
    private func sendButtonState(_ button: ButtonType) -> BehaviorRelay<Bool> {
        switch button {
        case .like:
            return likeButtonIsSelected
        case .repost:
            return repostButtonIsSelected
        case .comment:
            return commentButtonIsSelected
        }
    }
    
    
}
