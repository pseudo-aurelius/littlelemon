//
//  Home.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/2/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView() {
            Menu().tabItem() {
                Label("Menu", systemImage: "list.dash")
            }
            
            UserProfile().tabItem() {
                Label("Profile", systemImage: "square.and.pencil")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
