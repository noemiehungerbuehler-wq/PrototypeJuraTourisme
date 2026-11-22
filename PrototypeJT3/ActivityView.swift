//
//  ActivityView.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 14.01.25.
//

import SwiftUI

struct ActivityView: View {
    let activity : Activity
    
    var body: some View {
        VStack(spacing: 20) {
            Text(activity.title)
                .font(.largeTitle)
                .bold()
            Text("Category: \(activity.category.displayName)")
                .font(.title2)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

