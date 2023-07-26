//
//  APIServices.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import Foundation

protocol APIServicesProtocol {
    func fetchProducts(from endpoint: ProductListEndpoint, completion: @escaping (Result<[Product], APICallError>) -> ())
   
}

class APIServices: APIServicesProtocol {
    
    /// Shared Signleton of the api calls
    static let shared = APIServices()
    private let baseURL = "https://fakestoreapi.com/products"
 
    private let apiCall = URLSession.shared
    
    /// Using ProductListEndpoint to generate the right api endpoint for Fake Shopping API
    /// - Parameters:
    ///   - endpoint: category of product we need to access
    ///   - completion: returning the data needed
    func fetchProducts(from endpoint: ProductListEndpoint, completion: @escaping (Result<[Product], APICallError>) -> ()){
        guard let url = URL(string: "\(baseURL)\(endpoint.description)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url, completion: completion)
    }
    func fetchCategories(){
        guard let url = URL(string: baseURL+"/categories") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
               let categories = try JSONDecoder().decode([String].self, from: data)
                print(categories)
            } catch {
                print("Error decoding categories:", error)
            }
        }.resume()
    }
}


/// Diffrent product and the api endpoint
enum ProductListEndpoint: String, CaseIterable {
    
    case all = "All"
    case jewelery = "Jewelery"
    case electronics = "Electronics"
    case men = "Men's Clothing"
    case women = "Women's Clothing"
    
    var description: String {
        switch self {
        case .all: return "/"
        case .jewelery: return "/category/jewelery"
        case .electronics: return "/category/electronics"
        case .men: return "/category/men's%20clothing"
        case .women: return "/category/women's%20clothing"
        }
    }
}

extension APIServices {
    
    /// Call an api Endpoint and decode the data that it returns
    /// - Parameters:
    ///   - url: api call url with api key if needed
    ///   - parameters: url components, basicaly the html header needed
    ///   - completion: passing the data through a completion
    /// - Returns: decoded data or an API Endpoint Error
    private func loadURLAndDecode<T: Decodable>(url: URL, parameters: [String: String]? = nil, completion: @escaping (Result<T, APICallError>)-> ()){
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        apiCall.dataTask(with: finalURL){ (data, response, error) in
            
            if error != nil {
                completion(.failure(.apiError))
            }
            guard let urlResponse = response as? HTTPURLResponse, 200..<300 ~= urlResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

enum APICallError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case noData
    case invalidResponse
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .decodingError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

