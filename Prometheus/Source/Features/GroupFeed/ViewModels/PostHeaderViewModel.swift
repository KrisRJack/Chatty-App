//
//  PostHeaderViewModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/19/21.
//

import FirebaseStorage

final class PostHeaderViewModel: NSObject {
    
    public var presentErrorMessage: ((_ errorMessage: String) -> Void)?
    
    private var post: Post!
    
    public var headerString: String {
        post.firstName + " " + post.lastName
    }
    
    public var subHeaderString: String {
        post.username + " • " + post.timestamp.getElapsedInterval()
    }
    
    init(post model: Post) {
        post = model
        super.init()
        loadInitialData()
    }
    
    
    // MARK: - PRIVATE
    
    
    private func loadInitialData() {
        post.userReference.getDocument { snapshot, error in
            if let error = error {
                self.presentErrorMessage?("Unable to load profile image.")
                print(error.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else {
                self.presentErrorMessage?("User does not exist or may have been deleted.")
                return
            }
            
//            let imageReference =
            
        }
        
    }
    
}
