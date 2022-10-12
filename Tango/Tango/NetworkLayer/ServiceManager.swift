//
//  ServiceManager.swift
//  Tango
//
//  Created by sparecdmx on 10/10/22.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var paramters: [URLQueryItem] { get }
    var method: String { get }
}

enum ItunesEndpoint: Endpoint {
//    "https://itunes.apple.com/search?term=rammstein&entity=album"
    case getSearchResults(searchText: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseUrl: String{
        switch self {
        default:
            return "itunes.apple.com"
        }
    }
    
    var path: String{
        switch self {
        default:
            return "/search"
        }
    }
    
    var paramters: [URLQueryItem]{
        switch self {
        case .getSearchResults(let text):
            return [URLQueryItem(name: "term", value: text),
                    URLQueryItem(name: "entity", value: "album")]
        }
    }
    
    var method: String{
        switch self {
        default:
            return "get"
        }
    }
    
}

final class ServiceManager {
    
    static func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T , Error>) -> Void) {
        
        var components: URLComponents = {
            var comps = URLComponents()
            comps.scheme = endpoint.scheme
            comps.host = endpoint.baseUrl
            comps.path = endpoint.path
            comps.queryItems = endpoint.paramters
            return comps
        }()
        
        guard let url: URL = components.url else { return }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        URLSession.shared.dataTask(with: urlRequest) { data, resp, error in
            guard error == nil else {
                completion(.failure(error!) )
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                if let responceObj = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responceObj))
                } else {
                    let error = NSError(domain: "error decoding data", code: 200)
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
    
}
