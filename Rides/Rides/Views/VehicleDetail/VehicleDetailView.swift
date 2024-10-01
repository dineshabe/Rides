//
//  VehicleDetailView.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import SwiftUI

struct VehicleDetailsView: View {
    let model: Vehicle
    
    var body: some View {
        TabView {
            detailsView()
            emissionsView()
        }
        .tabViewStyle(.page)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .navigationTitle(model.makeAndModel.isEmpty ? "Vehicle Detail" : model.makeAndModel)
        .onAppear() {
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
            UIPageControl.appearance().pageIndicatorTintColor = .gray
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
                
                HStack {
                    Text(model.getEmissions())
                        .padding(.leading)
                    Spacer()
                }
                
                GroupBox(label: Label("Emissions calculation", systemImage: "questionmark.circle")) {
                    VStack(alignment: .leading) {
                        ForEach(Vehicle.emissionSlabs, id:\.self.rate) { slab in
                            if let upperLimit = slab.upperLimit {
                                Text("Emission rate of \(String(slab.rate)) till \(String(upperLimit))")
                            } else {
                                Text("Emission rate of \(String(slab.rate)) for the rest")
                            }
                        }
                    }
                    .fontWeight(.light)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}
