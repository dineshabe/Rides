//
//  VehicleListViewModel.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import Foundation
import SwiftUI

class VehicleListViewModel: ObservableObject {
    let client: RidesClient
    @Published var vehicles: [Vehicle] = []
    @Published var fetchCount: String = ""
    @Published var currentSort = Vehicle.SortKeys.vin
    @Published var selectedVehicleId: Int?
    
    init(client: RidesClient) {
        self.client = client
    }

    func fetchVehicles() {
        if let count = Int(fetchCount) {
            self.fetchVehicles(count: count)
        } else {
            //Display Error
        }
    }
    
    func sortVehicles(by key: Vehicle.SortKeys = .vin) {
        currentSort = key
        self.vehicles = self.performSort(key: key, items: self.vehicles)
    }
    
    private func fetchVehicles(count: Int) {
        Task {
            let result = try? await client.fetchVehicles(count: count)
            await MainActor.run {
                self.vehicles = (result ?? []).sorted { $0.vin < $1.vin }
            }
        }
    }
    
    private func performSort(key: Vehicle.SortKeys, items: [Vehicle]) -> [Vehicle] {
        switch(key) {
        case .kilometrage:
            items.sorted { $0.kilometrage < $1.kilometrage }
        case .licensePlate:
            items.sorted { $0.licensePlate < $1.licensePlate }
        case .mileage:
            items.sorted { $0.mileage < $1.mileage }
        case .vin:
            items.sorted { $0.vin < $1.vin }
        }
    }
}
