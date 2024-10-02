//
//  RidesApp.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import SwiftUI

@main
struct RidesApp: App {
    let ridesDependencyContainer = RidesDependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            VehicleListView(viewModel: VehicleListViewModel(client: ridesDependencyContainer.rideClient))
        }
    }
}
