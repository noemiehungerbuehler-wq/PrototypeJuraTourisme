

# Jura Tourisme — iOS UI Prototype

An interactive SwiftUI prototype designed to make discovering activities and local events in the **Canton of Jura (Switzerland)** simpler and more tailored to individual needs.

## About the Project

Finding local activities that match specific constraints—such as available time, group composition, age ranges, and interests—often requires browsing multiple fragmented websites. The long-term vision behind this project is an intelligent tourism assistant that automatically fetches regional events from the web and categorizes them by activity type, duration, group size, and target age group.

**Rapid Prototyping Experiment:**  
This repository was built in a single afternoon as an experiment to test how far AI-assisted code generation can accelerate early-stage iOS UI/UX prototyping. Rather than implementing a full backend, the goal was to quickly translate screen concepts and user flows into functional SwiftUI views.

## Features & Screens

* **Home (`HomeView`)**: Welcome overview introducing upcoming regional events and the planned automated event-fetching pipeline.
* **Discover (`SearchView`)**: Multi-criteria search form allowing users to filter activities by:
  * **Region**: Anywhere, Delémont, Franches-Montagnes, or Porrentruy
  * **Duration**: From a couple of hours up to two days
  * **Group Composition**: Individual steppers for Seniors, Adults, Teenagers, and Children
  * **Activity Type**: Sport, Food, and Culture toggles with input validation alerts
* **Interactive Map (`MapView`)**:
  * Centered on the Canton of Jura using `MapKit` with custom category pins (*Nature*, *Culture*, *Scenic View*, *Restaurant*, *Fun*)
  * Real-time user geolocation via `CoreLocation` (`LocationManager`) and quick map controls (zoom in/out, reset view, center on user)
  * Category filter sheet (`FilterSheet`) and bottom preview cards navigating to activity details (`ActivityView`)
* **Saved Activities (`LikedView`)**: Dedicated tab for bookmarking favorite activities discovered on the map or search screen.
* **Settings (`ProfileView`)**: User profile overview, multilingual interface selector (*Français*, *Deutsch*, *English*, *Italiano*), notification/location toggles, and a password change modal (`ChangePasswordView`).

<p align="center">
 <img width="250" alt="Simulator Screenshot - iPhone 17 - 1" src="https://github.com/user-attachments/assets/b77d225c-2e8c-474a-8992-c405c7f9f1bd" />
 <img width="250" alt="Simulator Screenshot - iPhone 17 - 2" src="https://github.com/user-attachments/assets/7a8ddf51-0faa-4769-974c-922c5f7b600f" />
  <img width="250" alt="Simulator Screenshot - iPhone 17 - 3" src="https://github.com/user-attachments/assets/a6d08a1b-a2a0-4f0a-9401-9f93f50d250a" />
</p>


## Tech Stack

* **Language**: Swift 5
* **UI Framework**: SwiftUI (`NavigationStack`, `TabView`, `Form`, `sheets`, `custom color assets`)
* **Location & Mapping**: `MapKit` & `CoreLocation`
* **IDE**: Xcode

## Project Structure

```text
PrototypeJT3/
├── Prototype_JT3App.swift   # App entry point
├── ContentView.swift        # Main 5-tab navigation bar & header
├── HomeView.swift           # Welcome & upcoming events overview
├── SearchView.swift         # Multi-criteria activity search form
├── MapView.swift            # Interactive Jura map, LocationManager & FilterSheet
├── ActivityView.swift       # Activity detail screen
├── LikedView.swift          # Saved/bookmarked activities view
├── ProfileView.swift        # User settings & ChangePasswordView
├── Activities.swift         # Activity data model, categories & sample Jura coordinates
└── Assets.xcassets          # App icons, logo & custom color palette
