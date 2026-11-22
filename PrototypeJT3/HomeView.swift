//
//  HomeView.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 13.01.25.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Jura Tourisme!")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Here you will find up-to-date information about events that will take place in the coming weeks.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Text("This View is still under construction, is should be able to do web scraping and display the events.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
