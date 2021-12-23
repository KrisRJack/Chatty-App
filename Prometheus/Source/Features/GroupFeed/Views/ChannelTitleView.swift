//
//  ChannelTitleView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit

final class ChannelTitleView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            titleLabel
        ])
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "nyc-running-group"
        label.textColor = .tertiaryTheme
        label.font = .systemFont(ofSize: 24, weight: .black)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(
            systemName: "number",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16, weight: .black))
        ))
        imageView.tintColor = .primaryTheme
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        fill(with: stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
