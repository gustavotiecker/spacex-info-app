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
    
    func getUpcomingLaunches(completion: @escaping (Result<[Launch], SXError>) -> Void) {
        let endpoint = baseURL + "/launches/upcoming"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launches = try decoder.decode([Launch].self, from: data)
                completion(.success(launches))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getRockets(completion: @escaping (Result<[Rocket], SXError>) -> Void) {
        let endpoint = baseURL + "/rockets"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let rockets = try decoder.decode([Rocket].self, from: data)
                completion(.success(rockets))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
            
            completion(image)
        }
        
        task.resume()
    }
}
