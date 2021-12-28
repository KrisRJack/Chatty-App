//
//  PostTextView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

final class PostTextView: UIView {
    
    public var text: String? {
        get { label.attributedStringForPost }
        set { label.attributedStringForPost = newValue }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .tertiaryTheme
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        fill(with: label, considerMargins: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
