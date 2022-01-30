//
//  CommentModelType.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/29/22.
//

import Foundation
import FirebaseFirestore
import Tagged

protocol CommentModelType {
    
    var id: ID { get }
    var text: String { get }
    var timestamp: Date { get }
    var userID: User.ID { get }
    var firstName: String { get }
    var lastName: String { get }
    var userame: User.Username { get }
    var postID: Post.ID { get }
    var groupID: Group.ID { get }
    
    var reference: DocumentReference { get }
    var referenceToUser: DocumentReference { get }
    
}

extension CommentModelType {
    
    typealias ID = Tagged<Comment, String>
    
}
