//
//  MapView.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 13.01.25.
//

import SwiftUI
import MapKit
import CoreLocation

// MARK: - Location Manager (stays alive as @StateObject)

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.userLocation = locations.last?.coordinate
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

// MARK: - MapView

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.3521, longitude: 7.2000), // Centered on Jura
        span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
    )

    @StateObject private var locationManager = LocationManager()
    @State private var selectedActivity: Activity? = nil
    @State private var showFilterSheet = false
    @State private var selectedCategories: Set<ActivityCategory> = Set(ActivityCategory.allCases)

    let activities = Activity.activities
    
    private var filteredActivities: [Activity] {
        activities.filter { selectedCategories.contains($0.category) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Map View with blue user location dot enabled
                Map(
                    coordinateRegion: $region,
                    showsUserLocation: true,
                    annotationItems: filteredActivities
                ) { activity in
                    MapAnnotation(coordinate: activity.coordinate) {
                        Button(action: {
                            selectedActivity = activity
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("Red"))
                                    .frame(width: 35, height: 35)
                                    .shadow(radius: 5)

                                Image(systemName: activity.category.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)

                // Selected activity card
                if let activity = selectedActivity {
                    VStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Text(activity.title)
                                .font(.headline)
                            Text(activity.category.displayName)
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            HStack {
                                Button(action: { selectedActivity = nil }) {
                                    Text("Close")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("Gray")))
                                }

                                Spacer()

                                NavigationLink(value: activity) {
                                    Text("More Information")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("Gray")))
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                    }
                }

                // Controls (filter button and right panel)
                VStack {
                    HStack {
                        VStack {
                            Button(action: { showFilterSheet = true }) {
                                Text("Filter")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                            }
                            .padding()
                            Spacer()
                        }

                        Spacer()

                        VStack {
                            Button(action: zoomIn) {
                                Image(systemName: "plus.magnifyingglass")
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .shadow(radius: 4)

                            Button(action: zoomOut) {
                                Image(systemName: "minus.magnifyingglass")
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .shadow(radius: 4)

                            Button(action: resetMap) {
                                Image(systemName: "arrow.counterclockwise")
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }

                            Button(action: locateMe) {
                                Image(systemName: "location.circle")
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
            .onAppear {
                locationManager.requestLocation()
            }
            .navigationDestination(for: Activity.self) { activity in
                ActivityView(activity: activity)
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(selectedCategories: $selectedCategories)
            }
        }
    }

    // MARK: - Functions right panel

    private func zoomIn() {
        region.span = MKCoordinateSpan(
            latitudeDelta: region.span.latitudeDelta / 2,
            longitudeDelta: region.span.longitudeDelta / 2
        )
    }

    private func zoomOut() {
        region.span = MKCoordinateSpan(
            latitudeDelta: region.span.latitudeDelta * 2,
            longitudeDelta: region.span.longitudeDelta * 2
        )
    }

    private func resetMap() {
        withAnimation {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 47.3521, longitude: 7.2000),
                span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
            )
        }
    }

    private func locateMe() {
        guard let userLocation = locationManager.userLocation else {
            locationManager.requestLocation()
            return
        }
        withAnimation {
            region = MKCoordinateRegion(
                center: userLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
}



// MARK: - FilterSheet

struct FilterSheet: View {
    @Binding var selectedCategories: Set<ActivityCategory>
    @Environment(\.dismiss) private var dismiss // Environment variable to dismiss the sheet

    var body: some View {
        NavigationStack {
            List(ActivityCategory.allCases, id: \.self) { category in
                HStack {
                    Text(category.displayName)
                    Spacer()
                    if selectedCategories.contains(category) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if selectedCategories.contains(category) {
                        selectedCategories.remove(category)
                    } else {
                        selectedCategories.insert(category)
                    }
                }
            }
            .navigationTitle("Filter Activities")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset Filters") {
                        selectedCategories = Set(ActivityCategory.allCases) // Reset filters to show all
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        dismiss() // Save changes and go back to the map
                    }
                }
            }
        }
        .accentColor(Color("Red"))
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
