//
//  LikeModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/22/21.
//

import FirebaseFirestore
import Foundation
import Tagged

public struct LikeModel {
    
    typealias ID = Tagged<LikeModel, String>
    
    let id: ID
    let userID: User.ID
    let postID: Post.ID
    let groupID: Group.ID
    let timestamp: Date
    
    var reference: DocumentReference {
        postReference.collection(.likes).document(id.rawValue)
    }
    
    var groupReference: DocumentReference {
        DatabaseService.collection(.groups).document(groupID.rawValue)
    }
    
    var postReference: DocumentReference {
        groupReference.collection(.posts).document(postID.rawValue)
    }
    
    var asDictionary: [String: Any] {
        get {
            return [
                DatabaseKeys.Like.id.rawValue: id.rawValue,
                DatabaseKeys.Like.userID.rawValue: userID.rawValue,
                DatabaseKeys.Like.postID.rawValue: postID.rawValue,
                DatabaseKeys.Like.groupID.rawValue: groupID.rawValue,
                DatabaseKeys.Like.timestamp.rawValue: timestamp,
            ]
        }
    }
    
}
