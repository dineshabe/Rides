//
//  EmptyStateView.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-30.
//

import SwiftUI

struct EmptyStateView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .fontWeight(.bold)
            
            Text(description)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: 300)
    }
}
