//
//  LaunchViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/3/22.
//

import RxSwift
import RxCocoa
import FirebaseFirestore

final class LaunchViewModel: NSObject {
    
    
    public var numberOfSections: Int { 1 }
    public var numberOfRowsInSection: Int { cellViewModels.count }
    public var navigationTitle: String { group.hashtag.rawValue }
    public var presentErrorMessage: PublishSubject<String> = PublishSubject<String>()
    public var didFinishFetchingInitialBatch: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    
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
                    presentErrorMessage.onNext(error.localizedDescription)
                    return
                }
                
                guard let snapshot = snapshot else {
                    didFinishFetchingInitialBatch.accept(true)
                    return
                }
                
                newestDocument = snapshot.documents.first
                oldestDocument = snapshot.documents.last
                didGetOldestDocumentOnServer = snapshot.documents.count < batchSize
                
                cellViewModels = snapshot.documents.map ({ document in
                    PostViewModel(post: Post(withData: document.data()))
                })
                
                didFinishFetchingInitialBatch.accept(true)
            }
    }
    
    
    public func viewModelForCell(at indexPath: IndexPath) -> PostViewModel {
        return cellViewModels[indexPath.row]
    }
}
