//
//  UIApplication.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 1/8/22.
//

import UIKit

extension UIApplication {
    
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}
