//
//  Double.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/29/21.
//

import Foundation

extension Double {
    
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
