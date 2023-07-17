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
      // let catImage: [] = ["mb","mb"]
       var body: some View {
           NavigationView {
               ScrollView {
                              LazyVStack {
                                  ForEach(categories, id: \.self) { category in
                                      NavigationLink(destination: ProductListView(category: category)) {
                                          CategoryRowView(category: category)
                                      }
                                  }
                              }
               }
                           .navigationTitle("Categories")
                       }
                       .onAppear {
                           DispatchQueue.main.async {
                               loadProductsForCategories()
                           }
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
       @EnvironmentObject var cart: CartViewModel
       @State var pickedCategory: ProductListEndpoint = .jewelery
       var body: some View {
           ZStack{
               Color.background.edgesIgnoringSafeArea(.all)
               ScrollView{
                   VStack {
                       
                       if productListObject.products != nil {
                           ProductList(products: productListObject.products!)
                               .environmentObject(cart)
                       } else {
                           LoadingView(isLoading: productListObject.isLoading, error: productListObject.error){ productListObject.loadProducts(with: pickedCategory)
                           }
                       }
                   }
                   
                   
                   
                   .onAppear {
                       DispatchQueue.main.async {
                           productListObject.loadProducts(with: category)
                       }
                   }
               }
           }
       }
   }
extension ProductListEndpoint {
    var image: Image {
        switch self {
        case .all:
            return Image(systemName: "")
        case .jewelery:
            return Image("jewelery")
        case .electronics:
            return Image("electronic1")
        case .men:
            return Image("MenClothes")
        case .women:
            return Image("womenClothes")
        }
    }
}
struct CategoryRowView: View {
    let category: ProductListEndpoint
    
    var body: some View {
        ZStack(alignment: .leading) {
            
                   category.image
                       .resizable()
                       .frame(width: 300, height: 100)
                       .cornerRadius(5)
                   
                   Text(category.rawValue)
                        .font(.system(size: 32,weight: .bold))
                       .foregroundColor(.white)
                       .padding(.bottom, 4)
                       .alignmentGuide(.leading) { _ in 0 }
               
        }
    }
}
