//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/2/24.
//

import SwiftUI

struct UserProfile: View {
    @State var firstName = UserDefaults.standard.string(forKey: keyFirstName)!
    @State var lastName = UserDefaults.standard.string(forKey: keyLastName)!
    @State var email = UserDefaults.standard.string(forKey: keyEmail)!
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack() {
            Header()
            
            VStack() {
                HStack() {
                    Text("Personal Information")
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    
                    Spacer()
                }
                
                ProfileDetail(label: "First Name", userDetail: $firstName)
                
                ProfileDetail(label: "Last Name", userDetail: $lastName)
                
                ProfileDetail(label: "Email", userDetail: $email)
                
                HStack() {
                    Button("Discard Changes") {
                        firstName = UserDefaults.standard.string(forKey: keyFirstName)!
                        lastName = UserDefaults.standard.string(forKey: keyLastName)!
                        email = UserDefaults.standard.string(forKey: keyEmail)!
                    }.padding(10).foregroundColor(Color(hex: "#333333")).font(.custom("AlNile-Bold", size: 15))
                        .background(Color(hex: "#EE9972")).cornerRadius(8).padding(.leading, 40)
                    
                    Spacer()
                    
                    Button("Save Changes") {
                        UserDefaults.standard.set(firstName, forKey: keyFirstName)
                        UserDefaults.standard.set(lastName, forKey: keyLastName)
                        UserDefaults.standard.set(email, forKey: keyEmail)
                    }.padding(10).foregroundColor(Color(hex: "#FFFFFF")).font(.custom("AlNile-Bold", size: 15))
                        .background(Color(hex: "#495E57")).cornerRadius(8).padding(.trailing, 40)
                    
                }.padding([.top, .bottom], 50)
                

            }.border(Color(hex: "#333333"), width: 2).cornerRadius(4).padding(15)
            
            Spacer()
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: keyLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }.padding([.top, .bottom], 10).padding([.leading, .trailing], 140).foregroundColor(Color(hex: "#333333")).font(.custom("AlNile-Bold", size: 15))
                .background(Color(hex: "#F4CE14")).cornerRadius(8)
                .padding(.bottom, 24)
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
