//
//  LogoView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

class LogoView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let appName = NSLocalizedString("App Name", comment: "Default logo should be the name of the app.")
    
    init(
        text: String = NSLocalizedString("App Name", comment: "Default logo should be the name of the app."),
        secondaryText: String? = nil,
        fontSize size: CGFloat = 16,
        alignment: NSTextAlignment = .center
    ) {
        super.init(frame: .zero)
        fill(with: label)
        setLabel(
            text: text,
            secondaryText: secondaryText,
            size: size,
            alignment: alignment
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabel(
        text: String,
        secondaryText: String?,
        size: CGFloat,
        alignment: NSTextAlignment
    ) {
        
        let mutableAttrString = NSMutableAttributedString()
            .append(secondaryText == nil ? text.trimmingCharacters(in: .whitespacesAndNewlines) : appName,
                    withFont: .systemFont(ofSize: size, weight: .black),
                    withColor: .tertiaryTheme)
            .append(".",
                    withFont: .systemFont(ofSize: size, weight: .black),
                    withColor: .primaryTheme)
        
        if let secondaryText = secondaryText {
            mutableAttrString.append(" \(secondaryText)",
                                     withFont: .systemFont(ofSize: size, weight: .regular),
                                     withColor: .secondaryLabel)
        }
        
        label.textAlignment = alignment
        label.attributedText = mutableAttrString
        
    }
    
}
