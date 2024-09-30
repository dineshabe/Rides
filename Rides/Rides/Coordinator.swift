//
//  Coordinator.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//
import Foundation
import SwiftUI

enum CoordinatorPath: Hashable {
    var hashValue: Int {
      switch self {
      case .vehicleDetails: return 0
      }
    }
    
    static func ==(lhs: CoordinatorPath, rhs: CoordinatorPath) -> Bool {
      return lhs.hashValue == rhs.hashValue
    }
    
    case vehicleDetails(Vehicle)
}

struct Coordinator {
    @ViewBuilder
    func getNavigationView(type: CoordinatorPath, path: Binding<NavigationPath>) -> some View {
        switch (type) {
            case let .vehicleDetails(vehicle):
                VehicleDetailsView(model: vehicle)
        }
    }
}
