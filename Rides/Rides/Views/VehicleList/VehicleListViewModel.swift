//
//  VehicleListViewModel.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import Foundation
import SwiftUI

class VehicleListViewModel: ObservableObject {
    let client: RideClientProtocol
    let errorMessage = "Please enter a value between 1 and 100"
    
    @Published var vehicles: [Vehicle] = []
    @Published var fetchCount: String = ""
    //Default sort by vin
    @Published var currentSort = Vehicle.SortKeys.vin
    @Published var selectedVehicleId: Int?
    @Published var displayError: Bool = false

    init(client: RideClientProtocol) {
        self.client = client
    }

    //MARK: View facing functions
    func fetchVehicles() async {
        //Clear old errors
        await MainActor.run {
            displayError = false
        }
        if let count = Int(fetchCount), count > 0 && count <= 100 {
            //Validation OK
            let result = try? await client.fetchVehicles(count: count)
            await MainActor.run {
                vehicles = performSort(key: currentSort, items: result)
            }
        } else {
            //Invalid input by the user
            await MainActor.run {
                displayError = true
            }
        }
    }
    
    func sortVehicles(by key: Vehicle.SortKeys) {
        currentSort = key
        self.vehicles = self.performSort(key: key, items: self.vehicles)
    }
    
    private func performSort(key: Vehicle.SortKeys, items: [Vehicle]?) -> [Vehicle] {
        guard let items = items else {
            return []
        }
        return items.sort(key: key)
    }
}
