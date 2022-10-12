//
//  ServiceManager.swift
//  Tango
//
//  Created by sparecdmx on 10/10/22.
//

import Foundation
 
final class ServiceManager {
    static let shared: ServiceManager = ServiceManager()

    func callService(url: String) {
        guard let urlObj: URL = URL(string: url) else { return }
        var request: URLRequest = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, resp, error) in
            guard
                error == nil,
                data != nil
            else { return }
            if let json = try? JSONDecoder().decode(FullResponse.self, from: data!) {
                print(json.results.map{ $0.album } )
            } else {
                print("nope")
            }
        }
        task.resume()
    }
    
    func callService(url: String, completion: @escaping ([String]) -> Void ) {
        guard let urlObj: URL = URL(string: url) else { return }
        var request: URLRequest = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, resp, error) in
            guard
                error == nil,
                data != nil
            else { return }
            if let json = try? JSONDecoder().decode(FullResponse.self, from: data!) {
                completion(json.results.map{ $0.album ?? "" })
            } else {
                print("nope")
            }
        }
        task.resume()
    }
}

