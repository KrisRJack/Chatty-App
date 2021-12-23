//
//  UIColor.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/2/21.
//

import UIKit

extension UIColor {
    
    // MARK: - Theme
    
    static var primaryTheme: UIColor {
        get {
            UIColor(named: "primaryTheme")!
        }
    }
    
    static var secondaryTheme: UIColor {
        get {
            UIColor(named: "secondaryTheme")!
        }
    }
    
    static var tertiaryTheme: UIColor {
        get {
            UIColor(named: "tertiaryTheme")!
        }
    }
    
    static var quaternaryTheme: UIColor {
        get {
            UIColor(named: "quaternaryTheme")!
        }
    }
    
    // MARK: - QR Code
    
    static var qrCode: UIColor {
        get {
            UIColor(named: "qrCode")!
        }
    }
    
    // MARK: - Camera
    
    static var cameraPlaceholder: UIColor {
        get {
            UIColor(named: "cameraPlaceholder")!
        }
    }
    
    // MARK: - Other
    
    static var softShadow: UIColor {
        get {
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        }
    }
    
    static var mediumShadow: UIColor {
        get {
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        }
    }
    
    static var hardShadow: UIColor {
        get {
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    static var dimmedModalBackgroundColor: UIColor {
        get {
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
    }
    
}
