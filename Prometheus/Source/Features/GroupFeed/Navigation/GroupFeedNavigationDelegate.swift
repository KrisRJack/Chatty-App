//
//  GroupFeedNavigationDelegate.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/31/21.
//

import Foundation

protocol GroupFeedNavigationDelegate {
    func goToMyGroups()
    func goToGroupDetails()
    func goToRepost(with viewModel: PostViewModel)
    func presentErrorMessage(error: String)
}
