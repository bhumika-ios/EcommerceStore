//
//  ProductList.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import SwiftUI

struct ProductList: View {
    @EnvironmentObject var cart: CartViewModel
    let products: [Product]
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var product: Product? = nil
    var body: some View {
        LazyVGrid(columns: columns){
            ForEach(products){product in
                VStack {
                    Button(action:{self.product = product}){
                        ProductListItem(product: product)
                    }
                    Button(action: {
                        withAnimation{
                            cart.addToCart(addedProduct: product, quantity: 1)
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "cart")
                            Text("Add to cart")
                                .font(.caption)
                                .bold()
                        }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.green)
                        .cornerRadius(5)
                    }).accessibility(identifier: "Add to cart\(product.id)")
                }
                .padding(.vertical,5)
                .padding(.horizontal,5)
                .padding(.vertical)
                .background(Color.white
                                .cornerRadius(5)
                                .shadow(color: .darkText.opacity(0.25), radius: 2.5, x: 2, y: 2))


                           //     .shadow(color: .darkText.opacity(0.05), radius: 2, x: 0.0, y: 0.0))
            }
            .padding()
        }.sheet(item: $product){product in
            ProductView(product: product).environmentObject(cart)
        }
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView  {
            ProductList(products: Product.sampleProducts).environmentObject(CartViewModel())
        }
    }
}

