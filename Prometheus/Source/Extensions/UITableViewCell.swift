//
//  UITableViewCell.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/3/21.
//

import UIKit

extension UITableViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self.self)
    }
    
}
