//
//  DatabaseService.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/18/21.
//

import Firebase
import FirebaseFirestore

public final class DatabaseService {
    
    public enum CollectionPath: String {
        case users = "users"
        case usernames = "usernames"
        case groupIDs = "groupIDs"
        case groups = "groups"
        case members = "members"
        case posts = "posts"
        case likes = "likes"
        case reposts = "reposts"
        case comments = "comments"
    }

    public static func collection(_ collectionPath: CollectionPath) -> CollectionReference {
        return Firestore.firestore().collection(collectionPath.rawValue)
    }
    
    public static func document(_ documentPath: String) -> DocumentReference {
        return Firestore.firestore().document(documentPath)
    }
    
}
