//
//  MessagePreviewCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/13/21.
//

import UIKit

final class MessagePreviewCell: UITableViewCell {
    
    private let view = MessagePreviewView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.fill(with: view, considerMargins: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
