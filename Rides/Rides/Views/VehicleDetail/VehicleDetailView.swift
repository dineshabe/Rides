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
        .navigationTitle(model.makeAndModel.isEmpty ? "Vehicle Detail" : model.makeAndModel)
    }
}
