//
//  Comment.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/24/22.
//

import FirebaseFirestore
import Tagged

struct Comment {
    let id: ID!
    let text: String!
    let timestamp: Date!
    let userID: User.ID
    let firstName: String!
    let lastName: String!
    let userame: User.Username!
    let postID: Post.ID!
    let groupID: Group.ID!
    
    var reference: DocumentReference {
        return DatabaseService
            .collection(.groups)
            .document(groupID.rawValue)
            .collection(.posts)
            .document(postID.rawValue)
            .collection(.comments)
            .document(id.rawValue)
    }
    
    var userReference: DocumentReference {
        return DatabaseService
            .collection(.users)
            .document(userID.rawValue)
    }
    
}


// MARK: - Typealias


extension Comment {
    
    typealias ID = Tagged<Comment, String>
    
}
