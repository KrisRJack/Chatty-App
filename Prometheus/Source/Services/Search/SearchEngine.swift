//
//  Search.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/22/22.
//

import Foundation
import AlgoliaSearchClient

final class SearchEngine: NSObject {
    
    
    private let client: SearchClient!
    
    
    override init() {
        client = SearchClient(
            appID: API_Keys.Algolia.APP_ID,
            apiKey: API_Keys.Algolia.API_KEY
        )
        super.init()
    }
    
    
    public func add<T: Encodable>(
        
        object: T,
        withID id: String,
        toIndex index: SearchEngine.Index,
        _ completion: @escaping (_ response: WaitableWrapper<ObjectRevision>?, _ error: Error?) -> Void
        
    ) {
        
        let objectID = ObjectID(rawValue: id)
        let indexName = IndexName(rawValue: index.rawValue)
        let index = client.index(withName: indexName)
        
        // If an object already exists, replace it.
        index.replaceObject(withID: objectID, by: object) { result in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    
    public func remove(
        
        objectWithID objectID: String,
        fromIndex index: SearchEngine.Index,
        _ completion: @escaping (_ response: WaitableWrapper<ObjectDeletion>?, _ error: Error?) -> Void
        
    ) {
        
        let objectID = ObjectID(rawValue: objectID)
        let indexName = IndexName(rawValue: index.rawValue)
        let index = client.index(withName: indexName)
        
        index.deleteObject(withID: objectID, requestOptions: .none) { result in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    
}


extension SearchEngine {
    
    public enum Index: String {
        case users = "users"
        case posts = "posts"
        case groups = "groups"
    }

}
