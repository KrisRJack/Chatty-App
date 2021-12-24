//
//  PostTextView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

final class PostTextView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .tertiaryTheme
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        fill(with: label, spacing: 20)
        backgroundColor = .secondarySystemBackground
        
        let attributedString = NSMutableAttributedString(
            string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Id volutpat lacus laoreet non."
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length)
        )
        label.attributedText = attributedString
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
