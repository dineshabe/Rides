//
//  ComponentTextView.swift
//  Rides
//
//  Created by Dinesh Thangasamy on 2024-09-29.
//

import SwiftUI

struct CaptionTextView: View {
    let caption: String
    let text: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(caption)
                    .foregroundColor(.gray)
                    .font(.footnote)
                Text(text)
            }
            
            Spacer()
        }
    }
}
