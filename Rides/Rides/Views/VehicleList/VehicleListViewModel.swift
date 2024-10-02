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
    
    @Published var canFetch: Bool = false
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    
    init(client: RideClientProtocol) {
        self.client = client
    }

    //MARK: View facing functions
    func validate() {
        if fetchCount.count > 0 {
            if let count = Int(fetchCount), count > 0 && count <= 100 {
                showError = false
                canFetch = true
            } else {
                showError = true
                canFetch = false
            }
        } else {
            showError = false
            canFetch = false
        }
    }
    
    func fetchVehicles() async {
        await startLoading()
        if canFetch {
            let result = try? await client.fetchVehicles(count: count)
            await finishLoading(result: result)
        } else {
            await finishLoading()
        }
    }
    
    func sortVehicles(by key: Vehicle.SortKeys) {
        currentSort = key
        self.vehicles = self.performSort(key: key, items: self.vehicles)
    }
    
    //MARK: Private functions
    private var count: Int {
        return Int(fetchCount) ?? 0
    }
    
    @MainActor
    private func startLoading() {
        //Reset error when we start loading
        isLoading = true
    }
    
    @MainActor
    private func finishLoading(result: [Vehicle]? = nil) {
        vehicles = performSort(key: currentSort, items: result)
        isLoading = false
    }
    
    private func performSort(key: Vehicle.SortKeys, items: [Vehicle]?) -> [Vehicle] {
        guard let items = items else {
            return []
        }
        return items.sort(key: key)
    }
}
