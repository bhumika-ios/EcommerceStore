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
            ScrollView {
                LazyVStack {
                    ForEach(categories, id: \.self.rawValue
                    ) { category in
                        NavigationLink(destination: ProductListView(productListObject: productListObject, category: category).environmentObject(cart)) {
                            CategoryRowView(category: category)
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
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
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
                }
                .onAppear {
                    DispatchQueue.main.async {
                        productListObject.loadProducts(with: category)
                    }
                }
            }
            .onChange(of: category) { newCategory in
                productListObject.loadProducts(with: newCategory)
            }
            .navigationTitle(category.rawValue)
            .padding(.top)
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
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 4)
                .alignmentGuide(.leading) { _ in 0 }
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

