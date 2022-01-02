//
//  Int.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/20/21.
//

import Foundation

extension Int {
    
    var roundedWithAbbreviations: String {
        
        let num = Double(self)
        let thousandNum = num / 1000
        let millionNum = num/1000000
        
        if num >= 1000 && num < 1000000 {
            
            if floor(thousandNum) == thousandNum { return ("\(Int(thousandNum))K") }
            return ("\(thousandNum.round(to: 1))K")
            
        }
        
        if num > 1000000 {
            
            if floor(millionNum) == millionNum { return ("\(Int(thousandNum))K") }
            return ("\(millionNum.round(to: 1))M")
            
        } else {
            
            if floor(num) == num { return ("\(Int(num))") }
            return ("\(num)")
            
        }
    }
    
}
