//
//  ProuctViewModel.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import Foundation

class  ProductsListObject: ObservableObject {
    @Published var products: [Product]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    var featuredProduct : [Product] {
        var fProducts: [Product] = []
        if let products = self.products  {
            if products.count >= 4 {
            fProducts = products[0...3].shuffled()
            }
        }
        return fProducts
    }
    
    /// Getting the api services singleton
    private let productListServices: APIServicesProtocol
    
    init(productServices: APIServicesProtocol = APIServices.shared){
        self.productListServices = productServices
    }
    
    /// Call the api services to get the product needed
    /// - Parameter url: category of products
    func loadProducts(with url: ProductListEndpoint){
        self.products = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
 
            self.isLoading = true
        }
        productListServices.fetchProducts(from: url) { (result) in
            DispatchQueue.main.async {
                self.isLoading = true
            }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.products = response
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error as NSError
                    print(error.localizedDescription)
                }
            }
        }
    }
    func reload(with category: ProductListEndpoint) {
            let newProductListObject = ProductsListObject()
            newProductListObject.loadProducts(with: category)
            products = newProductListObject.products
            isLoading = newProductListObject.isLoading
            error = newProductListObject.error
        }
}

