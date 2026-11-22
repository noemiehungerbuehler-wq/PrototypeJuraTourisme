//
//  LikedView.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 13.01.25.
//

import SwiftUI

struct LikedView: View {
    var body: some View {
        VStack{
            Text("Nothing saved yet")
                .font(.title)
                .padding()
            Text("To find activities go to discover or use the map. Once you've found an activity you like select the heart to save it.")
                .padding()
            // TODO
        }
        .padding()
    }
}

struct LikedView_Previews: PreviewProvider {
    static var previews: some View {
        LikedView()
    }
}
