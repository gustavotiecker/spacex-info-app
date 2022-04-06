//
//  RocketsViewModel.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 02/04/22.
//

import Foundation

protocol RocketsBusinessLogic {
    // MARK: - TableView Configuration
    func getNumberOfRows() -> Int
    func getRocket(at indexPath: IndexPath) -> Rocket
    
    // MARK: - Network
    func fetchRockets()
}

protocol RocketsViewDelegate: AnyObject {
    func didFetchRocketsWithSuccess()
    func didFetchRocketsWithError(message: String)
}

final class RocketsViewModel {
    
    // MARK: - Properties
    private var rockets: [Rocket] = []
    var networkService: NetworkServiceProtocol = NetworkService()
    weak var viewDelegate: RocketsViewDelegate?
}

extension RocketsViewModel: RocketsBusinessLogic {
    
    // MARK: - TableView Configuration
    func getNumberOfRows() -> Int {
        return rockets.count
    }
    
    func getRocket(at indexPath: IndexPath) -> Rocket {
        return rockets[indexPath.row]
    }
    
    // MARK: - Network
    func fetchRockets() {
        networkService.getRockets { result in
            switch result {
            case .success(let rockets):
                self.rockets = rockets
                self.viewDelegate?.didFetchRocketsWithSuccess()
            case .failure(let error):
                self.viewDelegate?.didFetchRocketsWithError(message: error.rawValue)
            }
        }
    }
}
