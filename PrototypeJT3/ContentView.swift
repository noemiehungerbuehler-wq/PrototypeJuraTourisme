//
//  ContentView.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 13.01.25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    init() {
            UITabBar.appearance().backgroundColor = UIColor.white // Background color
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "Gray") // Unselected icon color
        
            UITabBar.appearance().barTintColor = UIColor.white // Background for entire Tab Bar
        }
    
    @State private var isClicked = false
    
    var body: some View {
        
        VStack{
            HStack{
                Image("JuraTourismLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Spacer()
                Button(action: {
                    giveHelp()
                    isClicked.toggle()
                }) {
                    Image(systemName: "questionmark")
                    .frame(width: 30, height: 30)
                    .background(isClicked ? Color("Red") : Color("Gray"))
                    .foregroundColor(Color.white)
                    .cornerRadius(30)
                        
                }
                .padding(.trailing)
                
                
            }
            .padding(.horizontal)
            TabView {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }
                            .padding()

                        SearchView()
                            .tabItem {
                                Label("Discover", systemImage: "magnifyingglass")
                            }
                            .padding()
                
                        MapView()
                                .tabItem {
                                    Label("Map", systemImage: "map")
                                }
                                .padding()
                        
                        LikedView()
                            .tabItem {
                                Label("My Projects", systemImage: "heart")
                            }
                            .padding()
                
                        ProfileView()
                            .tabItem {
                                Label("Settings", systemImage: "gearshape")
                            }
                            .padding()
                        
                    }
            .accentColor(Color("Red"))
        }
        
    }
    
    private func giveHelp() {
        // TODO
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
