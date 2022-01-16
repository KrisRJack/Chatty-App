//
//  ComposeViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/13/22.
//

import Foundation

final class ComposeViewModel: NSObject {
    
    
    public enum CustomRowType {
        case text
        case repost
    }
    
    
    private var rows: [CustomRowType] = []
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
        rows.append(.repost)
        viewModelsAtIndex.append(postViewModel)
    }
    
    
    public func rowType(at indexPath: IndexPath) -> CustomRowType {
        rows[indexPath.item]
    }
    
    
    public func viewModelForRow(at indexPath: IndexPath) -> AnyObject? {
        viewModelsAtIndex[indexPath.item]
    }
    
}
