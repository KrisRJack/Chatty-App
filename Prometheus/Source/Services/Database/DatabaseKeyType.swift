//
//  DatabaseKeyType.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/18/21.
//

import Foundation

public protocol DatabaseKeyType {
    var rawValue: String { get }
}
