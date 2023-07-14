//
//  CategoryView.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 13/07/23.
//

import SwiftUI

struct CategoryView: View {
//    let category: String
//    @State private var categoryProducts: [Product] = []
   
    @ObservedObject var productListObject = ProductsListObject()
       let categories: [ProductListEndpoint] = [.jewelery, .electronics, .men, .women]
       
       var body: some View {
           NavigationView {
               List(categories, id: \.self) { category in
                   NavigationLink(destination: ProductListView(category: category)) {
                       Text(category.rawValue)
                   }
               }
               .navigationTitle("Categories")
           }
           .onAppear {
               loadProductsForCategories()
           }
       }
       
       private func loadProductsForCategories() {
           categories.forEach { category in
               productListObject.loadProducts(with: category)
           }
       }
   }

   struct ProductListView: View {
       @ObservedObject var productListObject = ProductsListObject()
       let category: ProductListEndpoint
       
       var body: some View {
           VStack {
               if productListObject.isLoading {
                   ProgressView()
               } else if let products = productListObject.products {
                   List(products) { product in
                       Text(product.title)
                   }
               } else if let error = productListObject.error {
                   Text(error.localizedDescription)
               }
           }
           .navigationTitle(category.rawValue)
           .onAppear {
               productListObject.loadProducts(with: category)
           }
       }
   }
