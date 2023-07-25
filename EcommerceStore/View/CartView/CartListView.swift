//
//  CartListView.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import SwiftUI

struct CartListView: View {
    @ObservedObject var cart: CartViewModel
    let products: [Product: Int]
    @Binding var showDelete: Bool
    var body: some View {
        let productsDic = products.map({$0.key})
        ScrollView{
            LazyVStack {
                ForEach(productsDic, id: \.self){key in
                    ZStack {
                        Button(action: {
                            withAnimation{
                                cart.removeFromCart(toRemove: key)
                            }
                        }){
                            HStack {
                                VStack {
                                    Spacer()
                                    Image(systemName: "xmark")
                                        .imageScale(.large)
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                               // .frame(width: 100)
                               // .background(Color.secondaryBackground)
                                //.frame(width: 100)
                                Spacer()
                            }
                        }
                        .padding()
                        .disabled(!showDelete)
                        CartListItem(cart: cart,product: key)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .offset(x:showDelete ? 50 : 0)
                    }.listRowBackground(Color.secondaryBackground)
                }
            }
        }
    }
}

struct CartList_Previews: PreviewProvider {
    static var previews: some View {
        CartListView(cart: CartViewModel(), products: [Product.sampleProducts[0]: 1], showDelete: .constant(true))
    }
}
