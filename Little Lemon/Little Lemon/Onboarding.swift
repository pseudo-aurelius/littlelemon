//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/2/24.
//

import SwiftUI

let keyFirstName: String = "first name key"
let keyLastName: String = "last name key"
let keyEmail: String = "email key"
let keyLoggedIn: String = "logged in key"

struct Onboarding: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var isLoggedIn: Bool = false;
    
    var body: some View {
        NavigationView() {
            VStack {
                
                NavigationLink("", destination: Home(), isActive: $isLoggedIn).onAppear() {
                    var loginStatus: String = UserDefaults.standard.string(forKey: keyLoggedIn) ?? "false"
                    var alreadyLoggedOn: Bool = Bool(loginStatus) ?? false
                    
                    if (alreadyLoggedOn) {
                        isLoggedIn = true;
                    }
                }
                
                VStack() {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                }.background(.green)
                
                Button("Register") {
                    if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                        UserDefaults.standard.set(firstName, forKey: keyFirstName)
                        UserDefaults.standard.set(lastName, forKey: keyLastName)
                        UserDefaults.standard.set(email, forKey: keyEmail)
                        
                        isLoggedIn = true;
                        UserDefaults.standard.set(isLoggedIn, forKey: keyLoggedIn)
                    } else {
                        // TO DO - Let the user know they need to fill out all forms
                    }
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
