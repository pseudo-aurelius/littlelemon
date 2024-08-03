//
//  Header.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/3/24.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack() {
            Spacer()
            
            // TO DO - Remove Hacky Workaround to Get Logo Centered
            Text("")
                .frame(width: 35, height: 35)
            
            Spacer()
            
            Image("Logo")
            
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 35, height: 35)
            
            Spacer()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
