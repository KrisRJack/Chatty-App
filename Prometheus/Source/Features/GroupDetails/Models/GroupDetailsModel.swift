//
//  GroupDetailsModel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/6/21.
//

import UIKit

final class GroupDetailsModel: NSObject {
    
    enum CellType {
        case about
        case bio
        case rules
        case members
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
        var cellType: CellType
    }
    
    
    static var sections: [Section] {
        [members, bio, rules, about, other]
    }
}

extension GroupDetailsModel {
    
    // MARK: - Header: Should be empty
    
    private static var header: Section {
        Section(title: nil, rows: [
            Row(
                title: nil,
                description: nil,
                systemImageName: nil,
                cellType: .bio
            )
        ])
    }
    
    // MARK: - Bio
    
    private static var bio: Section {
        Section(title: "Summary", rows: [
            Row(
                title: "Lorem Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                description: nil,
                systemImageName: nil,
                cellType: .bio
            )
        ])
    }
    
    // MARK: - Rules
    
    private static var rules: Section {
        Section(title: "Rules & Guidelines", rows: [
            
            Row(title: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                description: nil,
                systemImageName: nil,
                cellType: .rules
               ),
            
            Row(title: "Duis aute irure dolor",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                systemImageName: "1.circle.fill",
                cellType: .rules
               ),
            
            Row(title: "Lorem ipsum dolor sit amet",
                description: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                systemImageName: "2.circle.fill",
                cellType: .rules
               ),
            
            Row(title: "Ut enim ad minim veniam",
                description: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                systemImageName: "3.circle.fill",
                cellType: .rules
               )
            
        ])
    }
    
    // MARK: - About
    
    private static var about: Section {
        Section(title: "General Info", rows: [
            
            Row(title: "NYC Running Group",
                description: nil,
                systemImageName: "bubble.left.and.bubble.right",
                cellType: .about
               ),
            
            Row(title: " " + "nyc-running-group",
                description: nil,
                systemImageName: "number",
                cellType: .about
               ),
            
            Row(title: " " + "Public – anyone can participate",
                description: nil,
                systemImageName: "lock.open",
                cellType: .about
               ),
            
            Row(title: " " + "October 1, 2021",
                description: nil,
                systemImageName: "calendar",
                cellType: .about
               )
            
        ])
    }
    
    
    // MARK: - Members
    
    private static var members: Section {
        Section(title: "Community", rows: [
            
            Row(title: " " + "5",
                description: " " + "Moderators",
                systemImageName: "person.2",
                accessoryType: .disclosureIndicator,
                cellType: .members
               ),
            
            Row(title: "20,000",
                description: "Members",
                systemImageName: "person.3",
                accessoryType: .disclosureIndicator,
                cellType: .members
               ),
            
            Row(title: "  " + "Add New Member",
                description: nil,
                systemImageName: "person.crop.circle.fill.badge.plus",
                accessoryType: .none,
                cellType: .button
               )
            
        ])
    }
    
    // MARK: - Other
    
    private static var other: Section {
        Section(title: "Other", rows: [
            
            Row(title: "Report a Problem",
                description: nil,
                systemImageName: "exclamationmark.triangle",
                cellType: .button
               ),
            
            Row(title: "Leave Community",
                description: nil,
                systemImageName: "xmark.circle",
                cellType: .button
               )
            
        ])
    }
    
}
