//
//  ProductView.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import Foundation
import SwiftUI

struct ProductView: View {
    @EnvironmentObject var cart: CartViewModel
    @Environment(\.presentationMode) var presentation
    @State private var showSuccessMessage = false
    // deprecated in iOS 15 we should use @Environment(.\dismiss) var dismiss
    @State private var quantity: Int = 1
    let product: Product
    var body: some View {
        ZStack {
            Color.secondaryBackground.edgesIgnoringSafeArea(.bottom)
            VStack {
                Spacer()
                HStack{
                    Button(action:{presentation.wrappedValue.dismiss()}){
                        Image(systemName: "xmark")
                            .padding(8)
                            .background(Color.secondaryBackground)
                            .clipShape(Circle())
                    }
                    Spacer()
                }.padding()
                ProductImage(imageURL: product.imageURL).padding(.top)
                    .environmentObject(cart)
                ZStack {
                    Color.secondaryBackground.edgesIgnoringSafeArea(.bottom)
                        .cornerRadius(5)
                        .shadow(color: .accentColor.opacity(0.2), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    VStack(spacing: 0){
                        Text(product.title)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(24)
                        Text("\(product.price.format(f: ".02"))$")
                            .font(.headline)
//                        HStack(spacing: 2) {
//                            Text("\(product.formatedRating)").font(.title3)
//                            Text("(\(product.rating.manualCount))").font(.caption)
//                                .foregroundColor(.secondary)
//                                .offset(y: 3)
//                        }
                        .padding(8)
                        Text(product.description)
                            .foregroundColor(.secondary)
                            .padding()
                            .multilineTextAlignment(.center)
                        Spacer()
//                        VStack(spacing: 0) {
//                            Text("Quantity").font(.headline)
//                            Picker(selection: $quantity, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
//                                ForEach(1...10, id:\.self){quantity in
//                                    Text("\(quantity)").tag(quantity)
//                                }
//
//                            }).pickerStyle(SegmentedPickerStyle())
//                            .padding()
//                        }
                        Button(action: {
                            withAnimation{
                            cart.addToCart(addedProduct: product, quantity: quantity)
                           
                                showSuccessMessage = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                              
                                    showSuccessMessage = false
                                }
                                           }
                        }){
                            HStack {
                                Text("Add to cart").bold()
                            }
                        }.buttonStyle(AddCartButtonStyle(showSuccessMessage: showSuccessMessage))
                    }
                  
                }.edgesIgnoringSafeArea(.bottom)
                Spacer()
               
            }
            if showSuccessMessage {
                           Text("Successfully added to cart!")
                            .foregroundColor(.white) // Set text color to white
                            .padding()
                                               .background(Color.black)
                                               .cornerRadius(8)
                                               .frame(width: 240, height: 40) // Set the frame here
                                               .offset(y:265)
                                       
                       }
        }.navigationBarTitleDisplayMode(.large)
        // ajouter un navigation view vers le cart
    }
}

struct ProductImage: View {
    @EnvironmentObject var cart: CartViewModel
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 260, height: 300, alignment: .center)
                .cornerRadius(5)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(5)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(5)
        .shadow(color: .darkText.opacity(0.25), radius: 2.5, x: 2, y: 2)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}
struct ProductView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ProductView(product: Product.sampleProducts[6])
            .environmentObject(CartViewModel())
    }
}

//.padding(.leading, product == products.first ? 12 : 0)
//.padding(.trailing, product == products.last ? 12 : 0)
