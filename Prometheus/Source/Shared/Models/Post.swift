//
//  Post.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/18/21.
//

import FirebaseFirestore
import Tagged

class Post {
    
    let id: ID!
    let userID: User.ID!
    let firstName: String!
    let lastName: String!
    let username: String!
    let groupID: Group.ID!
    let priority: Int!
    let timestamp: Date!
    let text: String?
    let cellType: CustomCellType!
    
    var numOfLikes: Int = 0
    var numOfReposts: Int = 0
    var numOfComments: Int = 0
    
    let repost: Post?
    
    var reference: DocumentReference {
        return DatabaseService
            .collection(.groups)
            .document(groupID.rawValue)
            .collection(.posts)
            .document(id.rawValue)
    }
    
    var likesCollection: CollectionReference {
        return reference.collection(.likes)
    }
    
    var repostsCollection: CollectionReference {
        return reference.collection(.reposts)
    }
    
    var commentsCollection: CollectionReference {
        return reference.collection(.comments)
    }
    
    var repostedReference: DocumentReference? {
        guard let postID = repost?.id.rawValue, let groupID = repost?.groupID.rawValue else { return nil }
        return DatabaseService.collection(.groups).document(groupID).collection(.posts).document(postID)
    }
    
    var userReference: DocumentReference {
        return DatabaseService.collection(.users).document(userID.rawValue)
    }
    
    init(withData data: [String: Any]) {
        id = ID(rawValue: data[DatabaseKeys.Post.id.rawValue] as? String ?? "")
        userID = User.ID(rawValue: data[DatabaseKeys.Post.userID.rawValue] as? String ?? "")
        firstName = data[DatabaseKeys.Post.firstName.rawValue] as? String ?? ""
        lastName = data[DatabaseKeys.Post.lastName.rawValue] as? String ?? ""
        username = data[DatabaseKeys.Post.username.rawValue] as? String ?? ""
        groupID = Group.ID(rawValue: data[DatabaseKeys.Post.groupID.rawValue] as? String ?? "")
        text = data[DatabaseKeys.Post.text.rawValue] as? String
        priority = data[DatabaseKeys.Post.priority.rawValue] as? Int ?? 0
        timestamp = (data[DatabaseKeys.Post.timestamp.rawValue] as? Timestamp)?.dateValue() ?? Date()
        cellType = CustomCellType(rawValue: data[DatabaseKeys.Post.cellType.rawValue] as? Int ?? 0) ?? CustomCellType.none
        
        numOfLikes = data[DatabaseKeys.Post.numOfLikes.rawValue] as? Int ?? 0
        numOfComments = data[DatabaseKeys.Post.numOfComments.rawValue] as? Int ?? 0
        numOfReposts = data[DatabaseKeys.Post.numOfReposts.rawValue] as? Int ?? 0
        
        repost = cellType == .repost ? Post(withDataForRepost: data) : nil
    }
    
    init(withDataForRepost data: [String: Any]) {
        repost = nil
        priority = -1 // We don't care about priority here, but a value is required
        
        id = ID(rawValue: data[DatabaseKeys.Post.repostID.rawValue] as? String ?? "")
        userID = User.ID(rawValue: data[DatabaseKeys.Post.repostUserID.rawValue] as? String ?? "")
        firstName = data[DatabaseKeys.Post.repostFirstName.rawValue] as? String ?? ""
        lastName = data[DatabaseKeys.Post.repostLastName.rawValue] as? String ?? ""
        username = data[DatabaseKeys.Post.repostUsername.rawValue] as? String ?? ""
        groupID = Group.ID(rawValue: data[DatabaseKeys.Post.repostGroupID.rawValue] as? String ?? "")
        text = data[DatabaseKeys.Post.repostText.rawValue] as? String
        timestamp = (data[DatabaseKeys.Post.repostTimestamp.rawValue] as? Timestamp)?.dateValue() ?? Date()
        cellType = CustomCellType(rawValue: data[DatabaseKeys.Post.repostCellType.rawValue] as? Int ?? 0) ?? CustomCellType.none
    }
    
}

// MARK: - Typealias

extension Post {
    
    typealias ID = Tagged<Post, String>
    typealias Priority = Tagged<(Post, priority: ()), Int>
    
}
