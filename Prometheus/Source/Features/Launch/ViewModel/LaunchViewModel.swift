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
    
    
    /// UI can update when all values are `true` and custom views (such as reposts) are loaded
    private var didFetchContentForViewModelsAtIndex: [Bool] = [] {
        willSet {
            if newValue.allSatisfy({ $0 }) { didFinishLoadingData?() }
        }
    }
    
    
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
                    // Snaphot doesn't exist
                    didFinishLoadingData?()
                    return
                }
                
                newestDocument = snapshot.documents.first
                oldestDocument = snapshot.documents.last
                didGetOldestDocumentOnServer = snapshot.documents.count < batchSize
                didFetchContentForViewModelsAtIndex = [Bool](repeating: false, count: snapshot.documents.count)
                
                cellViewModels = snapshot.documents.map ({ document in
                    PostViewModel(post: Post(withData: document.data()))
                })
                
                cellViewModels.enumerated().forEach ({ index, viewModel in
                    viewModel.fetchContentIfNeeded (completion: { error in
                        didFetchContentForViewModelsAtIndex[index] = true
                    })
                })
                
            }
    }
    
    
    public func viewModelForCell(at indexPath: IndexPath) -> PostViewModel {
        return cellViewModels[indexPath.row]
    }
}
