//
//  SearchView.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 12/07/23.
//

import SwiftUI

struct SearchView: View {
    @State private var search: String = ""
    
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .padding()
                TextField("Search For Product", text: $search)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: .darkText.opacity(0.25), radius: 2.5, x: 2, y: 2)
            
            Image(systemName: "camera")
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: .darkText.opacity(0.25), radius: 2.5, x: 2, y: 2)
            
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
