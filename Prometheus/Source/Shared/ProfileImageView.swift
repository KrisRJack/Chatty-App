//
//  ProfileImageView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/8/21.
//

import UIKit

final class ProfileImageView: UIView {
    
    private var imageHeight: CGFloat { 170 }
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.cornerRadius((imageHeight - 9).halfOf)
        return imageView
    }()
    
    let shadowView: UIView = {
        let shadow = UIView()
        shadow.layer.shadowRadius = 2
        shadow.layer.shadowOpacity = 1
        shadow.layer.masksToBounds = false
        shadow.layer.shadowColor = UIColor.softShadow.cgColor
        shadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        return shadow
    }()

    private lazy var gradientView: UIView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.cornerRadius(imageHeight.halfOf)
        return imageView
    }()
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.quaternaryTheme.cgColor,
            UIColor.primaryTheme.cgColor,
        ]
        return gradientLayer
    }()
    
    init(primaryImage: UIImage?) {
        super.init(frame: .zero)
        fill(with: gradientView)
        gradientView.fill(with: mainImageView, spacing: 5)
        mainImageView.image = primaryImage
        
        [gradientView.heightAnchor.constraint(equalToConstant: imageHeight),
         gradientView.widthAnchor.constraint(equalToConstant: imageHeight)
        ].activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.borderWidth = 4
        mainImageView.layer.borderColor = UIColor.systemBackground.cgColor
        
        gradientLayer.frame = gradientView.bounds
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
