//
//  CategoryView.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 13/07/23.
//

import SwiftUI
import Combine

struct CategoryView: View {
    @EnvironmentObject var cart: CartViewModel
    @StateObject var productListObject = ProductsListObject()
    let categories: [ProductListEndpoint] = [.jewelery, .electronics, .men, .women]
    @State private var selectedCategory: ProductListEndpoint?
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack {
                        ForEach(categories, id: \.self.rawValue
                        ) { category in
                            NavigationLink(destination: ProductListView(productListObject: productListObject, category: category).environmentObject(cart)) {
                                CategoryRowView(category: category)
                                    .padding(.top)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Categories")
        }
      
        .onAppear {
            loadProductsForCategories()
        }
        .onChange(of: selectedCategory) { newCategory in
            if let category = newCategory {
                productListObject.reload(with: category)
            }
        }
    }
    
    private func loadProductsForCategories() {
        categories.forEach { category in
            productListObject.reload(with: category)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

struct ProductListView: View {
    @ObservedObject var productListObject: ProductsListObject
    let category: ProductListEndpoint
    @EnvironmentObject var cart: CartViewModel
    
    var body: some View {
    //    NavigationStack{
            ZStack {
                Color.background.ignoresSafeArea(.all)
                ScrollView {
                    VStack {
                        if productListObject.products != nil {
                            ProductList(products: productListObject.products!)
                                .environmentObject(cart)
                        } else {
                            LoadingView(isLoading: productListObject.isLoading, error: productListObject.error) {
                                productListObject.loadProducts(with: category)
                            }
                        }
                    }
             //   }
                .onAppear {
                    DispatchQueue.main.async {
                        productListObject.loadProducts(with: category)
                    }
                }
              
            }
            .onChange(of: category) { newCategory in
                productListObject.loadProducts(with: newCategory)
            }
          //  .navigationTitle(category.rawValue)
           // .navigationBarTitleDisplayMode(.inline)
            
            }
        .navigationTitle(category.rawValue)
      //  .navigationBarHidden(true)
//        .toolbar{
//            ToolbarItem(placement: .bottomBar){
//                Text(category.rawValue)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
//            }
//        }
    }
}


struct CategoryRowView: View {
    let category: ProductListEndpoint
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                category.image
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(5)
                    .alignmentGuide(.leading) { _ in 0 }
                    .offset(x:-16)
               // Spacer()
                Text(category.rawValue)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom, 4)
                   // .alignmentGuide(.leading) { _ in 0 }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color("green"))
            }
           
            .multilineTextAlignment(.leading)
            .padding()
            .frame(width: 300, height: 70)
            .background(Color.white)
            .cornerRadius(5)
         
        } .alignmentGuide(.leading) { _ in 0 }
    }
}

extension ProductListEndpoint {
    var image: Image {
        switch self {
        case .all:
            return Image(systemName: "")
        case .jewelery:
            return Image("jwel1")
        case .electronics:
            return Image("elec2")
        case .men:
            return Image("men2")
        case .women:
            return Image("women2")
        }
    }
}

