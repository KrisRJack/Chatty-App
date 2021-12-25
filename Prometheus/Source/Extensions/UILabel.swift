//
//  UILabel.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/24/21.
//

import Foundation
import UIKit

extension UILabel {
    
    var attributedStringForPost: String? {
        get { attributedText?.string }
        set {
            
            let attributedString = NSMutableAttributedString(string: newValue ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedString.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: paragraphStyle,
                range: NSMakeRange(0, attributedString.length)
            )
            attributedText = attributedString
            
        }
    }
    
}
