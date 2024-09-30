//
//  VehicleCell.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import SwiftUI

struct VehicleCell: View {
    let model: Vehicle
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.makeAndModel)
            Text(model.vin)
        }
    }
}
