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
    //Default sort by vin
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
    
    func sortVehicles(by key: Vehicle.SortKeys) {
        currentSort = key
        self.vehicles = self.performSort(key: key, items: self.vehicles)
    }
    
    private func fetchVehicles(count: Int) {
        Task {
            let result = try? await client.fetchVehicles(count: count)
            await MainActor.run {
                vehicles = performSort(key: currentSort, items: result)
            }
        }
    }
    
    private func performSort(key: Vehicle.SortKeys, items: [Vehicle]?) -> [Vehicle] {
        guard let items = items else {
            return []
        }
        return items.sort(key: key)
    }
}
