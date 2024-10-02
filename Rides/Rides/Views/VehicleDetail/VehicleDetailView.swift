//
//  VehicleDetailView.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import SwiftUI

struct VehicleDetailsView: View {
    let model: Vehicle
    
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                detailsView()
                    .tag(0)
                emissionsView()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationTitle(model.makeAndModel.isEmpty ? "Vehicle Detail" : model.makeAndModel)

            HStack {
                ForEach(0..<2) { index in
                    Circle()
                        .fill(index == currentPage ? Color.blue : Color.gray)
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top, 10)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func detailsView() -> some View {
        VStack(alignment: .leading) {
            GroupBox {
                CaptionTextView(caption: "vin", text: model.vin)
                
                CaptionTextView(caption: "Make and Model", text: model.makeAndModel)
                
                CaptionTextView(caption: "Color", text: model.color)
                
                CaptionTextView(caption: "Car Type", text: model.carType)

            }
            .padding()
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func emissionsView() -> some View {
        VStack(alignment: .leading) {
            GroupBox(label: Label("Total Emissions", systemImage: "smoke")) {
                
                Text(model.getEmissions().pretty)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)

                GroupBox(label: Label("Emissions calculation", systemImage: "questionmark.circle")) {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(Vehicle.emissionSlabs, id:\.self.rate) { slab in
                            if let upperLimit = slab.upperLimit {
                                Text("Emission rate of \(slab.rate.pretty)x till \(upperLimit.pretty)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text("Emission rate of \(slab.rate.pretty)x for the rest")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .fontWeight(.light)
                    .padding(.top, 5)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}
