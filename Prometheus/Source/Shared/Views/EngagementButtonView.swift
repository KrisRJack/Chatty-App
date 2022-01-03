//
//  EngagementButtonView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

class EngagementButtonView: UIControl {
    
    
    public var text: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }
    
    
    override public var isSelected: Bool {
        willSet {
            if !newValue {
                iconImageView.image = normalImage
                label.textColor = normalLabelColor
                iconImageView.tintColor = normalImageColor
            } else {
                iconImageView.image = selectedImage == nil ? normalImage : selectedImage
                label.textColor = selectedLabelColor == nil ? normalLabelColor : selectedLabelColor
                iconImageView.tintColor = selectedImageColor == nil ? normalImageColor : selectedImageColor
            }
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        willSet {
            if newValue {
        
                label.textColor = normalLabelColor
                iconImageView.tintColor = normalImageColor
                
            } else {
                
                label.textColor = .tertiaryLabel
                iconImageView.tintColor = .tertiaryLabel
                
            }
        }
    }
    
    private var normalImage: UIImage? = nil
    private var selectedImage: UIImage? = nil
    private var normalImageColor: UIColor = .tertiaryTheme
    private var selectedImageColor: UIColor? = nil
    private var normalLabelColor: UIColor = .tertiaryTheme
    private var selectedLabelColor: UIColor? = nil
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            label,
            iconImageView,
        ])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .body, weight: .medium)
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        fill(with: stackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setImage(withSystemName systemName: String, forState state: State) {
        let font: UIFont  = .preferredFont(forTextStyle: .footnote, weight: .regular)
        switch state {
        case .normal:
            normalImage = UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(font: font)
            )
        case .selected:
            selectedImage = UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(font: font)
            )
        default:
            fatalError("State not implemented.")
        }
        
        isSelected = isSelected
    }
    
    
    public func setImageColor(_ color: UIColor, forState state: State) {
        switch state {
        case .normal:
            normalImageColor = color
        case .selected:
            selectedImageColor = color
        default:
            fatalError("State not implemented.")
        }
        
        isSelected = isSelected
    }
    
    
    public func setTextColor(_ color: UIColor, forState state: State) {
        switch state {
        case .normal:
            normalLabelColor = color
        case .selected:
            selectedLabelColor = color
        default:
            fatalError("State not implemented.")
        }
        
        isSelected = isSelected
    }
    
}
