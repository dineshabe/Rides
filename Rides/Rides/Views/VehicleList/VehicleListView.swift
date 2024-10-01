//
//  VehicleListView.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import SwiftUI

struct VehicleListView: View {
    @StateObject private var viewModel: VehicleListViewModel = VehicleListViewModel(client: RidesClient())

    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading, spacing: 0) {
                headerView()
                
                List(viewModel.vehicles, selection: $viewModel.selectedVehicleId) { vehicle in
                    VehicleCell(model: vehicle)
                }
                .overlay(Group {
                    if viewModel.vehicles.isEmpty {
                        EmptyStateView(title: "No vehicles", description: "Please enter the number of vehicles you want to fetch and tap Get button")
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                                ForEach(Vehicle.SortKeys.allCases, id: \.self) { sortKey in
                                    Button{
                                        viewModel.sortVehicles(by: sortKey)
                                    } label: {
                                        if (sortKey == viewModel.currentSort) {
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
            getDetailView(with: viewModel.selectedVehicleId)
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        GroupBox {
            VStack {
                HStack {
                    TextField("Enter the count of vehicles to fetch", text: $viewModel.fetchCount)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Get") {
                        Task {
                            await viewModel.fetchVehicles()
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
                if viewModel.displayError {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .fontWeight(.light)
                }
            }
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
