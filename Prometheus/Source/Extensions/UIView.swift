//
//  UIView.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit

extension UIView {
    
    func cornerRadius(_ cornerRadius: CGFloat, corners: [UIRectCorner]? = nil) {
        guard let corners = corners else {
            layer.cornerRadius = cornerRadius
            return
        }
        
        var maskedCorners: CACornerMask = []
        
        for corner in corners {
            switch corner {
            case .topLeft:
                maskedCorners.update(with: .layerMinXMinYCorner)
            case .topRight:
                maskedCorners.update(with: .layerMaxXMinYCorner)
            case .bottomLeft:
                maskedCorners.update(with: .layerMinXMaxYCorner)
            case .bottomRight:
                maskedCorners.update(with: .layerMaxXMaxYCorner)
            default:
                continue
            }
        }
        
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
    }
    
    func fill(with view: UIView, spacing: CGFloat = 0, considerMargins: Bool = false) {
        let topAnchor = considerMargins ? layoutMarginsGuide.topAnchor : topAnchor
        let leftAnchor = considerMargins ? layoutMarginsGuide.leftAnchor : leftAnchor
        let rightAnchor = considerMargins ? layoutMarginsGuide.rightAnchor : rightAnchor
        let bottomAnchor = considerMargins ? layoutMarginsGuide.bottomAnchor : bottomAnchor
        
        addSubview(view, withConstraints: true)
        [view.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
         view.leftAnchor.constraint(equalTo: leftAnchor, constant: spacing),
         view.rightAnchor.constraint(equalTo: rightAnchor, constant: -spacing),
         view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
        ].activate()
    }
    
    func fill(with view: UIView, insets: UIEdgeInsets, considerMargins: Bool = false) {
        let topAnchor = considerMargins ? layoutMarginsGuide.topAnchor : topAnchor
        let leftAnchor = considerMargins ? layoutMarginsGuide.leftAnchor : leftAnchor
        let rightAnchor = considerMargins ? layoutMarginsGuide.rightAnchor : rightAnchor
        let bottomAnchor = considerMargins ? layoutMarginsGuide.bottomAnchor : bottomAnchor
        
        addSubview(view, withConstraints: true)
        [view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
         view.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left),
         view.rightAnchor.constraint(equalTo: rightAnchor, constant: insets.right),
         view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
        ].activate()
    }
    
    func addSubview(_ subview: UIView, withConstraints: Bool) {
        subview.translatesAutoresizingMaskIntoConstraints = !withConstraints
        addSubview(subview)
    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach ({ addSubview($0) })
    }
    
    func addSubviews(_ subviews: [UIView], withConstraints: Bool) {
        subviews.forEach ({
            $0.translatesAutoresizingMaskIntoConstraints = !withConstraints
            addSubview($0)
        })
    }
    
}
