//
//  ComposeTextCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/9/21.
//

import UIKit

final class ComposeTextCell: UITableViewCell {
    
    private let composeView = ComposeTextView()
    
    public var textViewDelegate: UITextViewDelegate? {
        set {
            composeView.textViewDelegate = newValue
        }
        get {
            composeView.textViewDelegate
        }
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: ComposeTextCell.reuseIdentifier)
        setUpViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        composeView.becomeFirstResponder()
    }
    
    private func setUpViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(composeView, withConstraints: true)
        [composeView.topAnchor.constraint(equalTo: contentView.topAnchor),
         composeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         composeView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
         composeView.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
        ].activate()
    }
    
}
