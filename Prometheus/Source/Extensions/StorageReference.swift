//
//  StorageReference.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/22/21.
//

import FirebaseStorage

extension StorageReference {
    
    public func child(_ path: StorageService.StoragePath) {
        self.child(path.rawValue)
    }
    
}
