//
//  GroupFeedViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/17/21.
//

import FirebaseFirestore

final class GroupFeedViewModel: NSObject {
    
    
    public var reloadData: (() -> Void)?
    public var numberOfSections: Int { 1 }
    public var endRefreshing: (() -> Void)?
    public var reloadAt: ((_ indexPath: IndexPath) -> Void)?
    public var presentErrorMessage: ((_ error: String) -> Void)?
    public var navigationTitle: String { group.hashtag.rawValue }
    public var numberOfRowsInSection: Int { cellViewModels.count }
    
    
    private var group: Group!
    private var ascendingQuery: Query!
    private var descendingQuery: Query!
    private var didGetOldestDocument: Bool = false
    private var newestDocument: QueryDocumentSnapshot?
    private var oldestDocument: QueryDocumentSnapshot?
    private var cellViewModels: [PostViewModel] = []
    
    
    init(group model: Group) {
        group = model
        super.init()
        ascendingQuery = group.postCollection.order(by: DatabaseKeys.Post.userID.rawValue)
            .order(by: DatabaseKeys.Post.timestamp.rawValue, descending: false)
        descendingQuery = group.postCollection
            .order(by: DatabaseKeys.Post.timestamp.rawValue, descending: true)
    }
    
    
    public func loadInitialBatch() {
        let batchSize = 10
        
        descendingQuery
            .limit(to: batchSize)
            .getDocuments { snapshot, error in
                if let error = error {
                    self.endRefreshing?()
                    self.presentErrorMessage?(error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }
                
                guard let snapshot = snapshot else {
                    self.reloadData?()
                    self.endRefreshing?()
                    return
                }
                
                self.newestDocument = snapshot.documents.first
                self.oldestDocument = snapshot.documents.last
                self.didGetOldestDocument = snapshot.documents.count < batchSize
                
                self.cellViewModels = snapshot.documents.map ({ document in
                    let viewModel = PostViewModel(post: Post(withData: document.data()))
                    viewModel.reloadAt = self.reloadAt
                    return viewModel
                })
                
                self.cellViewModels.enumerated().forEach ({ index, viewModels in
                    viewModels.indexPath = IndexPath(row: index, section: 0)
//                    viewModels.beginLoadingContentIfNeeded()
                })
                
                self.reloadData?()
                self.endRefreshing?()
            }
    }
    
    
    public func loadNewerBatch() {
        guard let newestDocument = newestDocument else {
            loadInitialBatch()
            return
        }
        
        ascendingQuery
            .start(afterDocument: newestDocument)
            .limit(to: 10)
            .getDocuments { snapshot, error in
                if let error = error {
                    self.endRefreshing?()
                    self.presentErrorMessage?(error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }
                
                guard let snapshot = snapshot, !snapshot.isEmpty else {
                    self.endRefreshing?()
                    return
                }
                
                self.newestDocument = snapshot.documents.last
                let newData: [PostViewModel] = snapshot.documents.reversed().map({ document in
                    PostViewModel(post: Post(withData: document.data()))
                })
                
                self.cellViewModels = newData + self.cellViewModels
                
                self.cellViewModels.enumerated().forEach ({ index, viewModels in
                    viewModels.indexPath = IndexPath(row: index, section: 0)
//                    viewModels.beginLoadingContentIfNeeded()
                })
                
                self.reloadData?()
                self.endRefreshing?()
            }
    }
    
    
    public func loadOlderBatch() {
        let batchSize = 10
        
        if didGetOldestDocument { return }
        
        guard let oldestDocument = oldestDocument else {
            loadInitialBatch()
            return
        }
        
        descendingQuery
            .start(afterDocument: oldestDocument)
            .limit(to: batchSize)
            .getDocuments { snapshot, error in
                
                if let error = error {
                    self.presentErrorMessage?(error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }
                
                guard let snapshot = snapshot, !snapshot.isEmpty else { return }
                
                self.oldestDocument = snapshot.documents.last
                self.didGetOldestDocument = snapshot.documents.count < batchSize
                
                let olderData: [PostViewModel] = snapshot.documents.reversed().map({ document in
                    PostViewModel(post: Post(withData: document.data()))
                })
                
                self.cellViewModels = self.cellViewModels + olderData
                
                self.cellViewModels.enumerated().forEach ({ index, viewModels in
                    viewModels.indexPath = IndexPath(row: index, section: 0)
//                    viewModels.beginLoadingContentIfNeeded()
                })
                
                self.reloadData?()
            }
    }
    
    
    public func viewModelForCell(at indexPath: IndexPath) -> PostViewModel {
        return cellViewModels[indexPath.row]
    }
    
    
}
