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
    let text: String!
    let priority: Int!
    let timestamp: Date!
    
    let repostID: Post.ID?
    let repostGroupID: Group.ID?
    
    var numOfLikes: Int!
    var numOfReposts: Int!
    var numOfComments: Int!
    
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
        guard let postID = repostID?.rawValue, let groupID = repostGroupID?.rawValue else { return nil }
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
        text = data[DatabaseKeys.Post.text.rawValue] as? String ?? ""
        priority = data[DatabaseKeys.Post.priority.rawValue] as? Int ?? 0
        timestamp = (data[DatabaseKeys.Post.timestamp.rawValue] as? Timestamp)?.dateValue() ?? Date()
        
        if let postID = data[DatabaseKeys.Post.repostID.rawValue] as? String,
            let groupID = data[DatabaseKeys.Post.repostGroupID.rawValue] as? String {
            repostID = Post.ID(rawValue: postID)
            repostGroupID = Group.ID(rawValue: groupID)
        } else {
            repostID = nil
            repostGroupID = nil
        }
        
        numOfLikes = data[DatabaseKeys.Post.numOfLikes.rawValue] as? Int ?? 0
        numOfComments = data[DatabaseKeys.Post.numOfComments.rawValue] as? Int ?? 0
        numOfReposts = data[DatabaseKeys.Post.numOfReposts.rawValue] as? Int ?? 0
    }
    
}

// MARK: - Typealias

extension Post {
    
    typealias ID = Tagged<Post, String>
    typealias Priority = Tagged<(Post, priority: ()), Int>
    
}
