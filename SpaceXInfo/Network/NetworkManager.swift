//
//  NetworkManager.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import UIKit

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum EndPoint {
    case upcomingLaunches
    case rockets
    
    func getPath() -> String {
        switch self {
        case .upcomingLaunches:
            return "/launches/upcoming"
        case .rockets:
            return "/rockets"
        }
    }
    
    func getHttpMethod() -> HttpMethod {
        switch self {
        case .upcomingLaunches, .rockets:
            return .get
        }
    }
}

enum APIError: String, Error {
    case invalidRequest = "Invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data receveid from the server was invalid. Please try again."
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.spacexdata.com/v4"
    
    private init() {}
    
    func request(body: String = "", endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> Void) {
        
        guard let url = URL(string: baseURL + endPoint.getPath()) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
            
            completion(.success(data))
        }
        task.resume()
    }
    
    func getLatestLaunch(completion: @escaping (Result<Launch, SPXError>) -> Void) {
        let endpoint = baseURL + "/launches/latest"
        
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
                let launch = try decoder.decode(Launch.self, from: data)
                completion(.success(launch))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getNextLaunch(completion: @escaping (Result<Launch, SPXError>) -> Void) {
        let endpoint = baseURL + "/launches/next"
        
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
                let launch = try decoder.decode(Launch.self, from: data)
                completion(.success(launch))
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
