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
                
                Image("Logo")
                    .padding(.bottom)
                    .padding(.top)
                
                Hero()
                    .padding(.bottom, 15)
                
                VStack() {
                    ProfileDetail(label: "First Name*", userDetail: $firstName)
                    ProfileDetail(label: "Last Name*", userDetail: $lastName)
                    ProfileDetail(label: "Email*", userDetail: $email)
                }
                
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
                }.padding([.top, .bottom], 10).padding([.leading, .trailing], 140).foregroundColor(Color(hex: "#333333")).font(.custom("AlNile-Bold", size: 15))
                    .background(Color(hex: "#F4CE14")).cornerRadius(8)
                    .padding(.top, 15)
                
                Spacer()
                
                NavigationLink("", destination: Home(), isActive: $isLoggedIn).onAppear() {
                    let loginStatus: String = UserDefaults.standard.string(forKey: keyLoggedIn) ?? "false"
                    let alreadyLoggedOn: Bool = Bool(loginStatus) ?? false
                    
                    if (alreadyLoggedOn) {
                        isLoggedIn = true;
                    }
                }
            }.background(Color(hex: "#FBDABB"))
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
