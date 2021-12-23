//
//  SubtitleCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/9/21.
//

import UIKit

public struct SubtitleCellModel {
    let titleString: String?
    let detailString: String?
    let iconImage: UIImage?
    let accessoryType: UITableViewCell.AccessoryType
}

open class SubtitleCell: UITableViewCell {
    
    required public init(reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
        
        tintColor = .tertiaryTheme
        textLabel?.textColor = .tertiaryTheme
        detailTextLabel?.textColor = .tertiaryTheme
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: SubtitleCellModel) {
        accessoryType = model.accessoryType
        imageView?.image = model.iconImage
        textLabel?.attributedText = attributedString(model.titleString ?? "", withLineSpacing: 2)
        detailTextLabel?.attributedText = attributedString(model.detailString ?? "", withLineSpacing: 2)
    }
    
    // MARK: Private
    
    private func attributedString(_ string: String, withLineSpacing lineSpacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
