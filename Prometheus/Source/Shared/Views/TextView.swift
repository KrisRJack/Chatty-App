//
//  TextView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/9/21.
//

import UIKit

class TextView: UITextView {
    
    /// String value of the placeholder
    var placeholder: String {
        get {
            return self.placeholderTextView.text
        }
        set {
            self.placeholderTextView.text = newValue
        }
    }
    
    /// Should the placeholder be visible
    private var showPlaceholder = true {
        willSet {
            newValue ? (placeholderTextView.isHidden = false) : (placeholderTextView.isHidden = true)
        }
    }
    
    override var font: UIFont? {
        willSet {
            self.placeholderTextView.font = newValue
        }
    }
    
    override var isScrollEnabled: Bool {
        willSet {
            self.placeholderTextView.isScrollEnabled = newValue
        }
    }
    
    override var showsVerticalScrollIndicator: Bool {
        willSet {
            self.placeholderTextView.showsVerticalScrollIndicator = newValue
        }
    }
    
    override var showsHorizontalScrollIndicator: Bool {
        willSet {
            self.placeholderTextView.showsHorizontalScrollIndicator = newValue
        }
    }
    
    private lazy var placeholderTextView: UITextView = {
        let textView = UITextView()
        textView.font = self.font
        textView.isHidden = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.frame.origin = .zero
        textView.backgroundColor = .clear
        textView.frame.size = frame.size
        textView.textColor = .secondaryLabel
        textView.text = "Type text here..." 
        return textView
    }()
    
    init(frame: CGRect) {
        super.init(frame: CGRect.zero, textContainer: nil)
        setUpViews()
    }
    
    required init() {
        super.init(frame: .zero, textContainer: nil)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderTextView.frame = bounds
        addSubview(placeholderTextView)
        bringSubviewToFront(placeholderTextView)
    }
    
    @objc private func textViewTapped() {
        becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUpViews() {
        placeholderTextView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(textViewTapped))
        )

        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification,
                                               object: self, queue: nil) { [weak self] notification in
            guard let _ = self else { return }
            guard let text = self!.text else {
                self!.showPlaceholder = true
                return
            }
            text.isEmpty ? (self!.showPlaceholder = true) : (self!.showPlaceholder = false)
        }
    }
    
    
}
