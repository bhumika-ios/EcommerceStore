//
//  ShoppingButtonStyle.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 12/07/23.
//

import SwiftUI

struct AddCartButtonStyle: ButtonStyle {
    var showSuccessMessage: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        VStack() {
            HStack {
                Spacer()
                Image(systemName: configuration.isPressed ? "cart.badge.plus" : "cart")
                   
              //  Spacer()
                Text("Add to Cart").bold()
                Spacer()
            }
//            HStack {
//                Spacer()
//                if configuration.isPressed {
//                    Text("Go to Cart").bold() // Change the text here
//                        .foregroundColor(.tertiary)
//                } else {
//                    configuration.label
//                }
//                Spacer()
//            }
        }
        .foregroundColor(.tertiary)
        .padding()
        .background(
            Group{
                if configuration.isPressed {
                    Color("green")
                } else {
                    Color("green")
                }
            }
        )
        .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
        .cornerRadius(5)
        .padding(.horizontal)
    }
}
