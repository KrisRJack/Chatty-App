//
//  DatabaseKeys.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/18/21.
//

import Foundation

public struct DatabaseKeys {
    
    public enum User: String, DatabaseKeyType {
        case uid = "uid"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case username = "username"
        case imageJPGName = "imageJPGName"
        case usernameReference = "usernameReference"
        case created = "created"
        case dateOfBirth = "dateOfBirth"
    }
    
    public enum Username: String, DatabaseKeyType {
        case id = "id"
        case created = "created"
        case userID = "uid"
        case username = "username"
        case taken = "taken"
        case userReference = "userReference"
    }
    
    public enum GroupIDs: String, DatabaseKeyType {
        case taken = "taken"
        case created = "created"
        case groupID = "groupID"
        case groupReferenceID = "groupReferenceID"
        case createdByUserWithID = "createdByUserWithID"
    }
    
    public enum Group: String, DatabaseKeyType {
        case id = "id"
        case name = "name"
        case hashtag = "hashtag"
        case createdOn = "createdOn"
        case description = "description"
        case createdByUserID = "createdByUserID"
    }
    
    public enum GroupMembership: String, DatabaseKeyType {
        case id = "id"
        case role = "role"
        case joined = "joined"
        case userID = "userID"
    }
    
    public enum Post: String, DatabaseKeyType {
        case id = "id"
        case text = "text"
        case userID = "userID"
        case firstName = "firstName"
        case lastName = "lastName"
        case username = "username"
        case groupID = "groupID"
        case priority = "priority"
        case timestamp = "timestamp"
        
        case likes = "likes"
        case reposts = "reposts"
        case comments = "comments"
        
        case numOfLikes = "numOfLikes"
        case numOfReposts = "numOfReposts"
        case numOfComments = "numOfComments"
    }
    
    public enum Like: String, DatabaseKeyType {
        case id = "id"
        case userID = "userID"
        case postID = "postID"
        case groupID = "groupID"
        case timestamp = "timestamp"
    }
    
}
