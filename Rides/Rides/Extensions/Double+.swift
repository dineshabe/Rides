//
//  Double+.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-10-01.
//
import Foundation

extension Double {
    var pretty: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
            
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
