//
//  Group.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import Tagged
import FirebaseStorage
import FirebaseFirestore

struct Group {
    let id: ID!
    let name: String!
    let hashtag: Hashtag!
    let createdOn: Date!
    let createdByUserID: User.ID!
    let desc: String!
    
    var reference: DocumentReference {
        return DatabaseService.collection(.groups).document(id.rawValue)
    }
    
    var postCollection: CollectionReference {
        return reference.collection(.posts)
    }
    
    var hashtagReference: DocumentReference {
        return DatabaseService.collection(.groupIDs).document(hashtag.rawValue.lowercased())
    }
    
    var createByUserReference: DocumentReference {
        return DatabaseService.collection(.users).document(createdByUserID.rawValue)
    }
    
    var primaryImageReference: StorageReference {
        return Storage.storage().reference(withPath: "groups").child("\(id.rawValue).0.jpeg")
    }
    
    var secondaryImageReference: StorageReference {
        return Storage.storage().reference(withPath: "groups").child("\(id.rawValue).1.jpeg")
    }
    
    init(
        id: ID,
        name: String,
        hashtag: Hashtag,
        createdOn: Date,
        createdByUserID: User.ID,
        description: String? = nil
    ) {
        self.id = id
        self.name = name
        self.hashtag = hashtag
        self.createdOn = createdOn
        self.createdByUserID = createdByUserID
        self.desc = description
    }
    
}

// MARK: - Typealias

extension Group {
    
    typealias ID = Tagged<Group, String>
    typealias Hashtag = Tagged<(Group, hashtag: ()), String>
    typealias Priority = Tagged<(Group, priority: ()), Int>
    
}
