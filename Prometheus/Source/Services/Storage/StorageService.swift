//
//  StorageService.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/22/21.
//

import FirebaseStorage

public final class StorageService {
    
    public enum StoragePath: String {
        case users = "users"
    }

    public static func reference(_ path: StoragePath) -> StorageReference {
        Storage.storage().reference(withPath: path.rawValue)
    }
    
}
