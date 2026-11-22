//
//  SearchView.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 13.01.25.
//

import SwiftUI

struct SearchView: View {
    // MARK: - State Variables
    @State private var selectedLocation: String = "Anywhere"
    @State private var selectedDuration: String = "Couple of hours"
    @State private var peopleAttending: [String: Int] = [
        "Senior": 0,
        "Adult": 1,
        "Teenager": 0,
        "Child": 0
    ]
    @State private var activityTypes: [String: Bool] = [
        "Sport": false,
        "Food": false,
        "Culture": false
    ]
    
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    private let locations = ["Anywhere", "Region Delémont", "Region Franches Montagnes", "Region Porrentruy"]
    private let durations = ["Couple of hours", "Half a day", "One day", "Two days"]
    
    // MARK: - View
    var body: some View {
        NavigationView {
            Form {
                // Location Picker
                Section(header: Text("Location")) {
                    Picker("Select a location", selection: $selectedLocation) {
                        ForEach(locations, id: \.self) { location in
                            Text(location)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Duration Picker
                Section(header: Text("Duration")) {
                    Picker("Select duration", selection: $selectedDuration) {
                        ForEach(durations, id: \.self) { duration in
                            Text(duration)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // People Attending
                Section(header: Text("People Attending")) {
                    ForEach(peopleAttending.keys.sorted(), id: \.self) { category in
                        Stepper("\(category): \(peopleAttending[category] ?? 0)", value: Binding(
                            get: { peopleAttending[category] ?? 0 },
                            set: { peopleAttending[category] = $0 }
                        ), in: 0...10)
                    }
                }
                
                // Activity Types
                Section(header: Text("Activity Type")) {
                    ForEach(activityTypes.keys.sorted(), id: \.self) { activity in
                        Toggle(activity, isOn: Binding(
                            get: { activityTypes[activity] ?? false },
                            set: { activityTypes[activity] = $0 }
                        ))
                        .tint(Color("Red"))
                    }
                }
                
                // Research Button
                Section {
                    Button(action: startResearch) {
                        Text("Research")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("Red"))
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Discover")
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Actions TODO logic
    private func startResearch() {
        // Check if the total number of people is 0
        let totalPeople = peopleAttending.values.reduce(0, +)
        if totalPeople == 0 {
            errorMessage = "You must select at least one person to attend."
            showError = true
            return
        }
        
        // Check if no activity types are selected
        let selectedActivities = activityTypes.filter { $0.value }
        if selectedActivities.isEmpty {
            errorMessage = "You must select at least one activity type."
            showError = true
            return
        }
        
        // Proceed with research logic
        print("Starting research with:")
        print("Location: \(selectedLocation)")
        print("Duration: \(selectedDuration)")
        print("People Attending: \(peopleAttending)")
        print("Activity Types: \(selectedActivities.map { $0.key })")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
