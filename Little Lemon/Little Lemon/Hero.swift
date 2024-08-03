//
//  Hero.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/3/24.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack() {
            HStack() {
                Text("Little Lemon")
                    .font(.custom("AlNile-Bold", size: 48))
                    .foregroundColor(Color(hex: "#F4CE14"))
                    .padding(.bottom, -15)
                    .padding(15)

                Spacer()
            }.padding(.bottom, -30)
            
            HStack() {
                VStack(alignment: .leading) {
                    Text("Chicago")
                        .font(.custom("AlNile-Bold", size: 28))
                        .foregroundColor(Color(hex: "#FFFFFF"))
                        .padding([.leading, .trailing], 15)
                        .padding(.top, -5)
                    
                    Text("Try our modern takes on some classic Mediterranean staples")
                        .font(.custom("AlNile-Bold", size: 14))
                        .foregroundColor(Color(hex: "#FFFFFF"))
                        .padding(15)
                }
                
                Image("Hero image")
                    .resizable()
                    .frame(width: 125, height: 125)
                    .cornerRadius(16)
                    .padding(5)
                    .padding(.bottom, 20)
                
                Spacer()
            }
        }.frame(width: .infinity, height: 200).background(Color(hex: "#495E57"))
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}
