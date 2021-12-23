//
//  UICollectionViewCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import UIKit

extension UICollectionViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self.self)
    }
    
}
