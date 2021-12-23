//
//  MyGroupCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/4/21.
//

import UIKit

final class MyGroupCell: UICollectionViewCell {
    
    private var imageHeight: CGFloat { frame.height / 2.6 }
    
    // MARK: - View Initialization
    
    // MARK: Image
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mockGroupPrimaryImage"))
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeight.halfOf
        return imageView
    }()
    
    // MARK: Stack View
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            mainImageView,
            primaryLabel,
            secondaryLabel,
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .tertiaryTheme
        label.text = "NYC Running Group"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "2K Members"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: - View Life Cycle
    
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
    
    private func setUpViews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.backgroundColor = .secondarySystemBackground
        
        [mainImageView.widthAnchor.constraint(equalToConstant: imageHeight),
         mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor)
        ].activate()
        
        fill(with: stackView, insets: UIEdgeInsets(top: 30, left: 12, bottom: -8, right: -12))
    }
    
}
