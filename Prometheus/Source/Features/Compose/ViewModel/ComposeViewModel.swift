//
//  ComposeViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/13/22.
//

import FirebaseFirestore

final class ComposeViewModel: NSObject {
    
    
    public enum CustomRowType {
        case text
        case repost
    }
    

    private var text: String?
    private var rows: [CustomRowType] = []
    private var cellType: CustomCellType = .none
    private var viewModelsAtIndex: [AnyObject?] = []
    
    
    public var numberOfSections: Int { 1 }
    public var numberOfRowsInSection: [Int : Int] { [0: rows.count] }
    
    
    override init() {
        super.init()
        rows.append(.text)
        viewModelsAtIndex.append(nil)
    }
    
    
    convenience init(postViewModel: PostViewModel) {
        self.init()
        cellType = .repost
        rows.append(.repost)
        viewModelsAtIndex.append(postViewModel)
    }
    
    
    public func rowType(at indexPath: IndexPath) -> CustomRowType {
        rows[indexPath.item]
    }
    
    
    public func viewModelForRow(at indexPath: IndexPath) -> AnyObject? {
        viewModelsAtIndex[indexPath.item]
    }
    
    
    public func textDidChange(to string: String?) {
        text = string
    }
    
    
    public func preparePreviewViewModel() -> ComposePreviewViewModel {
        var post: Post?
        let timestamp = Date()
        let priority = Int(Double(timestamp.timeIntervalSince1970))
        
        for (index, value) in rows.enumerated() {
            if value == .repost {
                if let postViewModel = viewModelsAtIndex[index] as? PostViewModel {
                    post = postViewModel.post
                }
            }
        }
        
        return ComposePreviewViewModel(post: Post(
            id: "mockID",
            userID: "mockUserID",
            firstName: "Kris",
            lastName: "Jackson",
            username: "KrisRJack",
            groupID: "mockGroupID",
            priority: priority,
            timestamp: timestamp,
            text: text,
            cellType: cellType,
            repost: post
        ))
    }
    
}
