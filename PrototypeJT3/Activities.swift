//
//  Activities.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 14.01.25.
//

import Foundation
import CoreLocation

struct Activity: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: ActivityCategory
    let coordinate: CLLocationCoordinate2D
    
    // Custom implementation for `Hashable`
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Use `id` for hashing
    }

    // Custom implementation for `Equatable`
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        lhs.id == rhs.id // Compare using `id`
    }

    static let activities = [
        Activity(title: "Park", category: .tree, coordinate: CLLocationCoordinate2D(latitude: 47.343, longitude: 7.338)),
        Activity(title: "Library", category: .book, coordinate: CLLocationCoordinate2D(latitude: 47.356, longitude: 7.325)),
        Activity(title: "Le Béridier", category: .camera, coordinate: CLLocationCoordinate2D(latitude: 47.380, longitude: 7.345)),
        Activity(title: "Forest", category: .tree, coordinate: CLLocationCoordinate2D(latitude: 47.362, longitude: 7.320)),
        Activity(title: "Maison Wenger", category: .restaurant, coordinate: CLLocationCoordinate2D(latitude: 47.223, longitude: 6.957)),
        Activity(title: "Auberge-Restaurant St-Hubert", category: .restaurant, coordinate: CLLocationCoordinate2D(latitude: 47.437, longitude: 7.033)),
        Activity(title: "Préhisto-Parc", category: .fun, coordinate: CLLocationCoordinate2D(latitude: 47.360, longitude: 6.914))
    ]
}

// MARK: - Activity Categories
enum ActivityCategory: CaseIterable {
    case tree
    case book
    case camera
    case restaurant
    case fun

    // Image for each category
    var imageName: String {
        switch self {
        case .tree:
            return "leaf.fill"
        case .book:
            return "book.fill"
        case .camera:
            return "camera.fill"
        case .restaurant:
            return "fork.knife"
        case .fun:
            return "figure.archery"
        }
    }

    // Display name for each category
    var displayName: String {
        switch self {
        case .tree:
            return "Nature"
        case .book:
            return "Culture"
        case .camera:
            return "Scenic View"
        case .restaurant:
            return "Restaurant"
        case .fun:
            return "Fun"
        }
    }
}
