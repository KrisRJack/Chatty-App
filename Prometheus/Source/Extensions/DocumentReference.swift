//
//  DocumentReference.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/22/21.
//

import FirebaseFirestore

extension DocumentReference {
    
    public func collection(_ collectionPath: DatabaseService.CollectionPath) -> CollectionReference {
        return self.collection(collectionPath.rawValue)
    }
    
}
