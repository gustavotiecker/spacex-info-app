//
//  NetworkManager.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.spacexdata.com/v4"
    
    private init() {}
    
    func getUpcomingLaunches(completetion: @escaping (Result<[Launch], SXError>) -> Void) {
        let endpoint = baseURL + "/launches/upcoming"
        
        guard let url = URL(string: endpoint) else {
            completetion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completetion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completetion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completetion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
                let launches = try decoder.decode([Launch].self, from: data)
                completetion(.success(launches))
            } catch {
                completetion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
