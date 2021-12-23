//
//  ComposeTextView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/9/21.
//

import UIKit

final class ComposeTextView: UIView {
    
    private var imageHeight: CGFloat { 50 }
    
    public var textViewDelegate: UITextViewDelegate? {
        set {
            textView.delegate = newValue
        }
        get {
            textView.delegate
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var textView: TextView = {
        let textView = TextView()
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = .tertiaryTheme
        textView.font = .systemFont(ofSize: 20)
        textView.placeholder = "Type something profound..."
        return textView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeight.halfOf
        imageView.image = UIImage(named: "mockProfileImage")
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setUpViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func becomeFirstResponder() -> Bool {
        textView.becomeFirstResponder()
    }
    
    private func setUpViews() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        addSubviews([
            containerView,
            profileImageView
        ], withConstraints: true)
        
        containerView.fill(with: textView, insets: UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0))
        [profileImageView.widthAnchor.constraint(equalToConstant: imageHeight),
         profileImageView.heightAnchor.constraint(equalToConstant: imageHeight),
         
         profileImageView.topAnchor.constraint(equalTo: topAnchor),
         profileImageView.leftAnchor.constraint(equalTo: leftAnchor),
         
         containerView.topAnchor.constraint(equalTo: topAnchor),
         containerView.rightAnchor.constraint(equalTo: rightAnchor),
         containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
         containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: imageHeight),
         containerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        ].activate()
    }
    
}
