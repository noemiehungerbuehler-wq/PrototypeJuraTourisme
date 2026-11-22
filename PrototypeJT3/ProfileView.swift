//
//  ProfileView.swift
//  Prototype JT3
//
//  Created by Noemie Hungerbuehler on 13.01.25.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - State Variables
    @State private var pseudo: String = "JohnDoe123"
    @State private var email: String = "john.doe@example.com"
    @State private var isLocationOn: Bool = true
    @State private var isNewsletterAccepted: Bool = false
    @State private var showChangePasswordSheet: Bool = false
    @State private var selectedLanguage: String = "English"
    
    private let selectlang = ["Français", "Deutsch", "English", "Italiano"]

    // MARK: - View
    var body: some View {
        NavigationView {
            Form {
                // User Information Section
                Section(header: Text("User Information")) {
                    HStack {
                        Text("User Name")
                        Spacer()
                        Text(pseudo)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(email)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Picker("Language", selection: $selectedLanguage) {
                            ForEach(selectlang, id: \.self) { selectlang in
                                Text(selectlang)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Button(action: changePassword) {
                        Text("Change Password")
                            .foregroundColor(Color("Red"))
                    }
                }
                
                // Settings Section
                Section(header: Text("Settings")) {
                    Toggle("Location Enabled", isOn: $isLocationOn)
                        .tint(Color("Red")) // Custom color
                    Toggle("Accept Newsletter", isOn: $isNewsletterAccepted)
                        .tint(Color("Red")) // Custom color
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showChangePasswordSheet) {
                ChangePasswordView()
            }
        }
    }
    
    private func changePassword() {
        showChangePasswordSheet = true
    }
}


// MARK: - Change psw View
struct ChangePasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Change Password")) {
                    SecureField("Current Password", text: $currentPassword)
                    SecureField("New Password", text: $newPassword)
                    SecureField("Confirm New Password", text: $confirmPassword)
                }
                Button(action: savePassword) {
                    Text("Save Password")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("Red"))
                        .cornerRadius(8)
                }
                .disabled(newPassword != confirmPassword || newPassword.isEmpty || currentPassword.isEmpty)
            }
            .navigationTitle("Change Password")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func savePassword() {
        // Add password change logic here
        print("Password changed successfully!")
        dismiss()
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
