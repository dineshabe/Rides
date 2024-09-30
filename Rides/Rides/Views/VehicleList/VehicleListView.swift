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
    
    @StateObject private var viewModel: VehicleListViewModel = VehicleListViewModel(client: RidesClient(), coordinator: Coordinator())

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section(header: headerView()) {
                    ForEach(viewModel.vehicles) { vehicle in
                        VehicleCell(model: vehicle)
                            .onTapGesture {
                                path.append(CoordinatorPath.vehicleDetails(vehicle))
                            }
                    }
                }
            }
            .overlay(Group {
                if viewModel.vehicles.isEmpty {
                    emptyView()
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
            .navigationDestination(for: CoordinatorPath.self) { selection in
                viewModel.coordinator.getNavigationView(type: selection, path: $path)
            }
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
    func emptyView() -> some View {
        VStack(alignment: .center) {
            Text("Please enter the number of vehicles you want to fetch and tap Get button")
                .padding()
                .fontWeight(.regular)
        }
    }
}

#Preview {
    VehicleListView()
}
