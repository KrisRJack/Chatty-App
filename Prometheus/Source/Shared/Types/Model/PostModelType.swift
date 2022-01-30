//
//  PostModelType.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/29/22.
//

import Tagged
import Foundation
import FirebaseStorage
import FirebaseFirestore

protocol PostModelType {
    
    var id: ID { get }
    var userID: User.ID { get }
    var firstName: String { get }
    var lastName: String { get }
    var username: User.Username { get }
    var profileImage: User.ImageJPGName { get }
    var groupID: Group.ID { get }
    var priority: Int { get }
    var timestamp: Date { get }
    var text: String? { get }
    var cellType: CustomCellType { get }

    var numOfLikes: Int { get set }
    var numOfReposts: Int { get set }
    var numOfComments: Int { get set }

    var repost: PostModelType? { get }
    
    var referenceToProfileImage: StorageReference { get }

    var reference: DocumentReference { get }
    var referenceToUser: DocumentReference { get }
    var referenceToRepost: DocumentReference? { get }
    
    var collectionOfLikes: CollectionReference { get }
    var collectionOfReposts: CollectionReference { get }
    var collectionOfComments: CollectionReference { get }

    var asDictionary: [DatabaseKeys.Post: Any?] { get }
    var asRawValueDictionary: [String: Any?] { get }
    var asDictionaryForRepost: [DatabaseKeys.Post: Any?] { get }
    
}


// MARK: - Typealias


extension PostModelType {
    
    typealias ID = Tagged<Post, String>
    
}
