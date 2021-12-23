//
//  HashTagView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/6/21.
//

import UIKit

final class HashTagView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            titleLabel
        ])
        stackView.spacing = 1
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .tertiaryTheme
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .primaryTheme
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(text: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        titleLabel.text = text
        fill(with: stackView)
        titleLabel.font = .systemFont(ofSize: fontSize, weight: .black)
        iconImageView.image = UIImage(
            systemName: "number",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: fontSize - 6, weight: .black))
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
