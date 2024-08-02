//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/2/24.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: keyFirstName)
    let lastName = UserDefaults.standard.string(forKey: keyLastName)
    let email = UserDefaults.standard.string(forKey: keyEmail)
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack() {
            Text("Personal Information")
            Image("profile-image-placeholder").scaledToFit()
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            
            Spacer()
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: keyLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
