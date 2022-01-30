//
//  User.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import FirebaseFirestore
import Tagged

struct User {
    typealias ID = Tagged<User, String>
    typealias Username = Tagged<User, String>
    typealias ImageJPGName = Tagged<User, String>
    
    let id: ID
    let email: String
    let firstName: String
    let lastName: String
    let username: Username
    let imageJPGName: ImageJPGName
    let created: Date
    let dateOfBirth: Date
    
    var reference: DocumentReference {
        DatabaseService.collection(.users).document(id.rawValue)
    }
    
    var usernameReference: DocumentReference {
        DatabaseService.collection(.usernames).document(username.rawValue.lowercased())
    }
    
    
    
}
