//
//  MainView.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var products = ProductsListObject()
    @StateObject var cartItems = CartViewModel()
    //@StateObject var user = UserViewModel()
    var body: some View {
        TabView{
            HomeView(productsList: products
//                     , user: user
            ).environmentObject(cartItems)
                .tabItem {
                    Image(systemName:"house")
                    Text("Home")
                }
           CategoryView(productListObject: products)
                  .environmentObject(cartItems)
                  .tabItem {
                      Image(systemName: "square.grid.2x2")
                      Text("Category")
                  }
            CartView(cartProducts: cartItems)
                //.environmentObject(user)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
         
        }
        .zIndex(10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

