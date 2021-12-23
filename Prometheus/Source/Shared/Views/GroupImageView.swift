//
//  GroupImageView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/6/21.
//

import UIKit

final class GroupImageView: UIView {
    
    private var primaryImageHeight: CGFloat { 150 }
    private var secondaryImageHeight: CGFloat { 160 }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            backgroundImageView,
            mainImageView,
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        imageView.isUserInteractionEnabled = true
        imageView.cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
        return imageView
    }()
    
    init(primaryImage: UIImage?, secondaryImage: UIImage?, alignment: UIStackView.Alignment = .center) {
        super.init(frame: .zero)
        
        stackView.alignment = alignment
        
        mainImageView.image = primaryImage
        backgroundImageView.image = secondaryImage
        
        addSubview(stackView, withConstraints: true)
        [stackView.topAnchor.constraint(equalTo: topAnchor),
         stackView.leftAnchor.constraint(equalTo: leftAnchor),
         stackView.rightAnchor.constraint(equalTo: rightAnchor),
         stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ].activate()
        
        stackView.spacing = -primaryImageHeight.halfOf
        mainImageView.layer.cornerRadius = primaryImageHeight.halfOf
        
        [mainImageView.widthAnchor.constraint(equalToConstant: primaryImageHeight),
         mainImageView.heightAnchor.constraint(equalToConstant: primaryImageHeight),
         backgroundImageView.heightAnchor.constraint(equalToConstant: secondaryImageHeight),
        ].activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.borderWidth = 6
        mainImageView.layer.borderColor = UIColor.systemBackground.cgColor
    }
}
