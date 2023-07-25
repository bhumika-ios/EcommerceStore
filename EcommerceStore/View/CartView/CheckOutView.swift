//
//  CheckOutView.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var cart: CartViewModel
    let products: [Product]
    let price:Double
    var taxes: Double {
        (price * 20 / 100)
    }
    var delivery: Double {
        if price > 100 {
            return 0
        } else {
            return 50
        }
    }
    var body: some View {
        VStack {
           Spacer()
            ZStack{
                Color.secondaryBackground.edgesIgnoringSafeArea(.bottom)
                Color.secondaryBackground.opacity(0.3).edgesIgnoringSafeArea(.bottom)
                VStack(alignment:.center, spacing: 0){
                    HStack{
                        Button(action: {withAnimation{cart.showShowcaseSheet.toggle()}}, label: {
                            Image(systemName: "xmark")
                                .imageScale(.medium)
                                .foregroundColor(.darkText)
                        }).padding(8)
                        .background(Color.secondaryBackground)
                        .clipShape(Circle())
                        Spacer()
                    }
                    //.padding()
                    Spacer()
                    ScrollView{
                    VStack{
                      
                            ForEach(products){product in
                                HStack {
                                    Text(product.title)
                                        .font(.system(size: 16))
                                        .lineLimit(1)
                                    Divider()
                                    Spacer()
                                    Text("\(product.price.format(f: ".2"))$").bold()
                                        .font(.system(size: 18))
                                    
                                }.padding(.horizontal)
                                    .padding(.vertical)
                                    .foregroundColor(.darkText)
                                   // .background(Color.background)
                                    .cornerRadius(5)
                                    .padding(.horizontal)
                                
                            }
                        }
                    }
                  //  .padding()
                    VStack{
                        HStack{
                            Text("Taxes:")
                                
                            Spacer()
                            Text("\(taxes.format(f: ".02"))$")
                               
                                //.font(.caption)
                        }
                        .font(.system(size: 18))
                            //.padding(.top)
                        HStack{
                            Text("Delivery: ")
                               
                            Spacer()
                            Text("\(delivery.format(f: ".02"))$")
                               
                               // .font(.caption)
                        }
                        .font(.system(size: 18))
                        Divider()
                        HStack{
                            Text("Total Price: ")
                                .font(.system(size: 18))
                            Spacer()
                            Text("\((price + taxes + delivery).format(f: ".02"))$")
                                .fontWeight(.bold)
                                .font(.system(size: 22))
                        }
                    }
                    .padding(.horizontal)
                    //.padding()
                    .padding(.vertical)
                    .background(Color.background)
                    .cornerRadius(5)
                   // .padding(.vertical)
                    .padding(.horizontal)
                    Button(action: {print("Paying ...")}) {
                        Text("Click Here to Pay").bold()
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("green"))
                            .cornerRadius(5)
                            .padding()
                    }
                    //.padding()
                }.foregroundColor(.darkText)
                Spacer()
            }.cornerRadius(5)
            .frame(height: 500)
        }
        .transition(.move(edge: .bottom))
        .zIndex(20)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(products: Array(Product.sampleProducts[0...2]), price: 500)
    }
}
