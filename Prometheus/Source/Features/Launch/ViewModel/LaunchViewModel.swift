//
//  LaunchViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/3/22.
//

import FirebaseFirestore

final class LaunchViewModel: NSObject {
    
    
    public var numberOfSections: Int { 1 }
    public var didFinishLoadingData: (() -> Void)?
    public var presentErrorMessage: ((_ error: String) -> Void)?
    public var numberOfRowsInSection: Int { cellViewModels.count }
    public var navigationTitle: String { group.hashtag.rawValue }
    
    
    private var group: Group!
    private var ascendingQuery: Query!
    private var descendingQuery: Query!
    private var cellViewModels: [PostViewModel] = []
    private var newestDocument: QueryDocumentSnapshot?
    private var oldestDocument: QueryDocumentSnapshot?
    private var didGetOldestDocumentOnServer: Bool = false
    
    
    init(group model: Group) {
        group = model
        
        // Sort feed chronologically
        ascendingQuery = group.postCollection.order(by: DatabaseKeys.Post.userID.rawValue)
            .order(by: DatabaseKeys.Post.timestamp.rawValue, descending: false)
        descendingQuery = group.postCollection
            .order(by: DatabaseKeys.Post.timestamp.rawValue, descending: true)
    }
    
    
    public func fetchInitialFeedData() {
        let batchSize = 10
        
        descendingQuery
            .limit(to: batchSize)
            .getDocuments { [self] snapshot, error in
                
                if let error = error {
                    presentErrorMessage?(error.localizedDescription)
                    return
                }
                
                guard let snapshot = snapshot else {
                    didFinishLoadingData?()
                    return
                }
                
                newestDocument = snapshot.documents.first
                oldestDocument = snapshot.documents.last
                didGetOldestDocumentOnServer = snapshot.documents.count < batchSize
                
                cellViewModels = snapshot.documents.map ({ document in
                    PostViewModel(post: Post(withData: document.data()))
                })
                
                didFinishLoadingData?()
                
            }
    }
    
    
    public func viewModelForCell(at indexPath: IndexPath) -> PostViewModel {
        return cellViewModels[indexPath.row]
    }
}
