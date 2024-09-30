//
//  VehicleListView.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import SwiftUI

struct VehicleListView: View {
    @State private var path = NavigationPath()
    @State var fetchCount: String = ""
    @State var currentSort = Vehicle.SortKeys.vin
    @State private var selectedVehicleId: Int?

    @StateObject private var viewModel: VehicleListViewModel = VehicleListViewModel(client: RidesClient())

    var body: some View {
        NavigationSplitView {
            VStack {
                headerView()
                    .padding([.leading, .trailing], 10)
                
                List(viewModel.vehicles, selection: $selectedVehicleId) { vehicle in
                    VehicleCell(model: vehicle)
                }
                .overlay(Group {
                    if viewModel.vehicles.isEmpty {
                        EmptyStateView(title: "No vehicles to show", description: "Please enter the number of vehicles you want to fetch and tap Get button")
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                                ForEach(Vehicle.SortKeys.allCases, id: \.self) { sortKey in
                                    Button{
                                        currentSort = sortKey
                                        viewModel.sortVehicles(by: sortKey)
                                    } label: {
                                        if (sortKey == currentSort) {
                                            Label(sortKey.rawValue, systemImage:"checkmark.circle.fill")
                                        } else {
                                            Text(sortKey.rawValue)
                                        }
                                    }
                                }
                           } label: {
                               Image(systemName: "list.bullet")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                           }
                    }
                }
                .navigationTitle("Vehicles")
            }
        } detail: {
            getDetailView(with: selectedVehicleId)
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            TextField("Enter the count of vehicles to fetch", text: $fetchCount)
                .textFieldStyle(.roundedBorder)
            
            Button("Get") {
                viewModel.fetchVehicles(fetchCount)
            }
            .buttonStyle(.bordered)
        }
    }
    
    @ViewBuilder
    func getDetailView(with id: Int?) -> some View {
        if let vehicle =  viewModel.vehicles.first(where: { $0.id == id }) {
            VehicleDetailsView(model: vehicle)
        } else {
            EmptyStateView(title: "No vehicles details to display", description: "Please select a vehicle to view its details here")
        }
    }
}

#Preview {
    VehicleListView()
}
