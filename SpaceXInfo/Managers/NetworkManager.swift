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
    
    func getUpcomingLaunches(completed: @escaping (Result<[Launch], SXError>) -> Void) {
        let endpoint = baseURL + "/launches/upcoming"
        
    }
}
