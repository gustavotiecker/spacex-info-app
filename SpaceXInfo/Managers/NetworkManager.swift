//
//  NetworkManager.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.spacexdata.com/v4"
    
    private init() {}
    
    func getUpcomingLaunches(completed: @escaping (Result<[Launch], SXError>) -> Void) {
        let endpoint = baseURL + "/launches/upcoming"
        
        AF.request(endpoint).response { response in
            
            guard let data = response.data else {
                completed(.failure(.invalidRequest))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launches = try decoder.decode([Launch].self, from: data)
                completed(.success(launches))
            } catch {
                completed(.failure(.invalidRequest))
            }
            
        }
    }
}
