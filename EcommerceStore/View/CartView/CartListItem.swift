//
//  CartListItem.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import SwiftUI
struct CartListItem: View {
    @ObservedObject var cart: CartViewModel
    let product: Product

    var body: some View {
        HStack(spacing: 16) {
            SmallCartListItemImage(imageURL: product.imageURL)
            VStack {
                
                Text(product.title)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .lineLimit(2)
              //  Text("\(product.price * Double(cart.cartProductDic[product] ?? 0)) $")
                Text(String(format: "%.2f $", product.price * Double(cart.cartProductDic[product] ?? 0)))

                    .font(.system(size: 18))
              //  Text("")
                HStack{
                    Text("Quantity")
                        .font(.system(size: 12))
                    Text("\(cart.cartProductDic[product] ?? 0)")
                        .frame(width: 50, height: 50)
                        .padding(.trailing)
                    Stepper(
                        onIncrement: {
                            cart.changeQuantity(product: product, quantity: (cart.cartProductDic[product] ?? 0) + 1)
                        },
                        onDecrement: {
                            cart.changeQuantity(product: product, quantity: max((cart.cartProductDic[product] ?? 0) - 1, 1))
                        },
                        label: {
                            
                            Text("\(cart.cartProductDic[product] ?? 0)")
                            
                        }
                    )
                    .frame(width: 50, height: 50)
                    .padding(.trailing)
                }
            }
            Spacer()
            VStack{
//                Text("\(cart.cartProductDic[product] ?? 0)")
//                               .frame(width: 50, height: 50)
//                               .padding(.trailing)
//                Stepper(
//                    onIncrement: {
//                        cart.changeQuantity(product: product, quantity: (cart.cartProductDic[product] ?? 0) + 1)
//                    },
//                    onDecrement: {
//                        cart.changeQuantity(product: product, quantity: max((cart.cartProductDic[product] ?? 0) - 1, 1))
//                    },
//                    label: {
//
//                        Text("\(cart.cartProductDic[product] ?? 0)")
//
//                    }
//                )
//                .frame(width: 50, height: 50)
//                .padding(.trailing)
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .padding(.leading, 8)
        .background(Color.secondaryBackground)
    }
}



struct CartListItem_Previews: PreviewProvider {
    static var previews: some View {
        CartListItem(cart: CartViewModel(), product: Product.sampleProducts[1])
    }
}

struct SmallCartListItemImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 140, alignment: .center)
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
                                    .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                    }.padding()
                )
        }
        .cornerRadius(5)
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}
