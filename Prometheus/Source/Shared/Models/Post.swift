//
//  Post.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/18/21.
//

import FirebaseStorage
import FirebaseFirestore
import Tagged

class Post: PostModelType {
    
    var id: ID
    var userID: User.ID
    var firstName: String
    var lastName: String
    var username: User.Username
    var profileImage: User.ImageJPGName
    var groupID: Group.ID
    var priority: Int
    var timestamp: Date
    var text: String?
    var cellType: CustomCellType
    
    var numOfLikes: Int = 0
    var numOfReposts: Int = 0
    var numOfComments: Int = 0
    
    var repost: PostModelType?
    
    var reference: DocumentReference {
        return DatabaseService
            .collection(.groups)
            .document(groupID.rawValue)
            .collection(.posts)
            .document(id.rawValue)
    }
    
    var referenceToProfileImage: StorageReference {
        return StorageService.reference(.users).child(profileImage + ".jpg")
    }
    
    var collectionOfLikes: CollectionReference {
        return reference.collection(.likes)
    }
    
    var collectionOfReposts: CollectionReference {
        return reference.collection(.reposts)
    }
    
    var collectionOfComments: CollectionReference {
        return reference.collection(.comments)
    }
    
    var referenceToRepost: DocumentReference? {
        guard let postID = repost?.id.rawValue, let groupID = repost?.groupID.rawValue else { return nil }
        return DatabaseService.collection(.groups).document(groupID).collection(.posts).document(postID)
    }
    
    var referenceToUser: DocumentReference {
        return DatabaseService.collection(.users).document(userID.rawValue)
    }
    
    var asDictionary: [DatabaseKeys.Post: Any?] {
        var dict: [DatabaseKeys.Post: Any?] = [
            .id: id.rawValue,
            .userID: userID.rawValue,
            .firstName: firstName,
            .lastName: lastName,
            .username: username,
            .groupID: groupID.rawValue,
            .priority: priority,
            .timestamp: timestamp,
            .text: text,
            .cellType: cellType.rawValue,
            .numOfLikes: numOfLikes,
            .numOfReposts: numOfReposts,
            .numOfComments: numOfComments
        ]
        repost?.asDictionaryForRepost.forEach({ dict[$0] = $1 })
        return dict
    }
    
    var asRawValueDictionary: [String: Any?] {
        var dict: [String: Any?] = [:]
        asDictionary.forEach({ dict[$0.rawValue] = $1 })
        return dict
    }
    
    var asDictionaryForRepost: [DatabaseKeys.Post: Any?] {
        [
            .repostID: id.rawValue,
            .repostText: text,
            .repostUserID: userID.rawValue,
            .repostFirstName: firstName,
            .repostLastName: lastName,
            .repostUsername: username,
            .repostGroupID: groupID,
            .repostTimestamp: timestamp,
            .repostCellType: cellType.rawValue
        ]
    }
    
    init(
        id: String,
        userID: String,
        firstName: String,
        lastName: String,
        username: String,
        profileImage: String,
        groupID: String,
        priority: Int,
        timestamp: Date,
        text: String?,
        cellType: CustomCellType,
        numOfLikes: Int = 0,
        numOfReposts: Int = 0,
        numOfComments: Int = 0,
        
        repost: PostModelType? = nil
        
    ) {
        
        self.id = ID(rawValue: id)
        self.userID = User.ID(rawValue: userID)
        self.firstName = firstName
        self.lastName = lastName
        self.username = User.Username(rawValue: username)
        self.profileImage = User.ImageJPGName(rawValue: profileImage)
        self.groupID = Group.ID(rawValue: groupID)
        self.priority = priority
        self.timestamp = timestamp
        self.text = text
        self.cellType = cellType
        self.numOfLikes = numOfLikes
        self.numOfReposts = numOfReposts
        self.numOfComments = numOfComments
        
        self.repost = repost
    }
    
    init(withData data: [String: Any]) {
        id = ID(rawValue: data[DatabaseKeys.Post.id.rawValue] as? String ?? "")
        userID = User.ID(rawValue: data[DatabaseKeys.Post.userID.rawValue] as? String ?? "")
        firstName = data[DatabaseKeys.Post.firstName.rawValue] as? String ?? ""
        lastName = data[DatabaseKeys.Post.lastName.rawValue] as? String ?? ""
        username = User.Username(rawValue: data[DatabaseKeys.Post.username.rawValue] as? String ?? "")
        profileImage = User.ImageJPGName(rawValue: data[DatabaseKeys.Post.profileImage.rawValue] as? String ?? "")
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
        username = User.Username(rawValue: data[DatabaseKeys.Post.repostUsername.rawValue] as? String ?? "")
        profileImage = User.ImageJPGName(rawValue: data[DatabaseKeys.Post.profileImage.rawValue] as? String ?? "")
        groupID = Group.ID(rawValue: data[DatabaseKeys.Post.repostGroupID.rawValue] as? String ?? "")
        text = data[DatabaseKeys.Post.repostText.rawValue] as? String
        timestamp = (data[DatabaseKeys.Post.repostTimestamp.rawValue] as? Timestamp)?.dateValue() ?? Date()
        cellType = CustomCellType(rawValue: data[DatabaseKeys.Post.repostCellType.rawValue] as? Int ?? 0) ?? CustomCellType.none
    }
    
}
