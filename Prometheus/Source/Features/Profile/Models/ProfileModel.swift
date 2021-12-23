//
//  ProfileModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/7/21.
//

import UIKit

final class ProfileModel: NSObject {
    
    enum CellType {
        case bio
        case about
        case group
        case profession
        case link
        case button
    }
    
    struct Section {
        var title: String? = nil
        var footer: String? = nil
        var rows: [Row]
    }
    
    struct Row {
        var title: String?
        var description: String?
        var systemImageName: String?
        var accessoryType: UITableViewCell.AccessoryType = .none
        var cellType: CellType = .about
    }
    
    static var sections: [Section] {
        [bio, groups, about, links, other]
    }
}

extension ProfileModel {
    
    // MARK: - About
    
    private static var about: Section {
        Section(title: "About Me", rows: [
            
            Row(title: "NYC",
                description: "Location",
                systemImageName: "mappin",
                cellType: .about
               ),
            
            Row(title: "July 3, 1998",
                description: "Birthday",
                systemImageName: "app.gift",
                cellType: .about
               ),
            
            Row(title: "October 1, 2021",
                description: "Joined",
                systemImageName: "calendar",
                cellType: .about
               ),
            
            Row(title: "Software Engineer at Peloton",
                description: "Profession",
                systemImageName: "briefcase",
                cellType: .profession
               ),
            
        ])
    }
    
    // MARK: - Groups
    
    private static var groups: Section {
        Section(title: "Communities", rows: [
            
            Row(title: "20",
                description: "My Communities",
                systemImageName: "globe",
                accessoryType: .disclosureIndicator,
                cellType: .group
               ),
            
            Row(title: "Join A Community",
                description: nil,
                systemImageName: "plus",
                accessoryType: .none,
                cellType: .button
               )
            
        ])
    }
    
    // MARK: - Profession
    
    private static var profession: Section {
        Section(title: nil, rows: [
            
            Row(title: "Software Engineer at Peloton",
                description: "Profession",
                systemImageName: "briefcase",
                cellType: .profession
               ),
            
        ])
    }
    
    // MARK: - Bio
    
    private static var bio: Section {
        Section(title: "Bio", rows: [
            
            Row(title: """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                """,
                description: nil,
                systemImageName: nil,
                cellType: .bio
               ),
            
        ])
    }
    
    // MARK: - Links
    
    private static var links: Section {
        Section(title: "Links", rows: [
            
            Row(title: "www.krisrjack.com",
                description: "Personal",
                systemImageName: "safari.fill",
                accessoryType: .disclosureIndicator,
                cellType: .link
               ),
            
            Row(title: "github.krisrjack.com",
                description: "GitHub",
                systemImageName: "safari.fill",
                accessoryType: .disclosureIndicator,
                cellType: .link
               ),
            
            Row(title: "linkedin.krisrjack.com",
                description: "LinkedIn",
                systemImageName: "safari.fill",
                accessoryType: .disclosureIndicator,
                cellType: .link
               )
            
        ])
    }
    
    // MARK: - Other
    
    private static var other: Section {
        Section(title: "Other", rows: [
            
            Row(title: "Settings",
                description: nil,
                systemImageName: "gearshape",
                accessoryType: .disclosureIndicator,
                cellType: .button
               ),
            
            Row(title: "Log Out",
                description: nil,
                systemImageName: "rectangle.portrait.and.arrow.right",
                cellType: .button
               )
            
        ])
    }
    
}
