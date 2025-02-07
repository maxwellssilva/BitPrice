//
//  NetworkManager.swift
//  BitPrice
//
//  Created by Maxwell Silva on 06/02/25.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completionHandler: @escaping (Result<Double, NetworkError>) -> Void) {
        guard let url = URL(string: "https://www.blockchain.com/pt/ticker") else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonObject = try decoder.decode(TickerResponse.self, from: data)
                completionHandler(.success(jsonObject.BRL.buy))
            } catch {
                completionHandler(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
}
