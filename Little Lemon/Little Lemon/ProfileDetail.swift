//
//  ProfileDetail.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/3/24.
//

import SwiftUI

struct ProfileDetail: View {
    init(label: String, userDetail: Binding<String>) {
        self.label = label;
        self.storedText = userDetail
    }
    
    let label: String;
    @State var storedText: Binding<String>
    
    var body: some View {
        
        VStack() {
            HStack() {
                Text(label)
                    .font(.custom("AlNile", size: 12))
                    .foregroundColor(Color(hex: "#AFAFAF"))
                
                Spacer()
            }.padding(.bottom, -10)
            
            TextField("", text: storedText)
                .font(.custom("AlNile", size: 16))
                .foregroundColor(Color(hex: "#333333"))
                .padding(10)
                .border(Color(hex: "#333333"), width: 2)
                .cornerRadius(4)
            
        }.padding([.leading, .trailing], 15).padding([.top, .bottom], 5)
        
        
    }
}

struct ProfileDetail_Previews: PreviewProvider {
    @State static var testText = "Capria"
    
    static var previews: some View {
        ProfileDetail(label: "First Name", userDetail: $testText)
    }
}
