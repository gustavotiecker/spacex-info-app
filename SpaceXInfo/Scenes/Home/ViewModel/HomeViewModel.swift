//
//  HomeViewModel.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 04/04/22.
//

import Foundation

protocol HomeBusinessLogic {
    // MARK: - Access to the models
    func getLatestLaunch() -> Launch?
    func getNextLaunch() -> Launch?
    
    // MARK: - Network
    func fetchLatestLaunch()
    func fetchNextLaunch()
}

protocol HomeViewDelegate: AnyObject {
    func didFetchLatestLaunchWithSuccess()
    func didFetchNextLaunchWithSuccess()
    func didFetchWithError(message: String)
}

final class HomeViewModel {
    
    // MARK: - Properties
    private var latestLaunch: Launch?
    private var nextLaunch: Launch?
    var networkService: NetworkServiceProtocol = NetworkService()
    weak var viewDelegate: HomeViewDelegate?
}

extension HomeViewModel: HomeBusinessLogic {
    
    func getLatestLaunch() -> Launch? {
        return latestLaunch
    }
    
    func getNextLaunch() -> Launch? {
        return nextLaunch
    }
    
    func fetchLatestLaunch() {
        networkService.getLatestLaunch { result in
            switch result {
            case .success(let latestLaunch):
                self.latestLaunch = latestLaunch
                self.viewDelegate?.didFetchLatestLaunchWithSuccess()
            case .failure(let error):
                self.viewDelegate?.didFetchWithError(message: error.rawValue)
            }
        }
    }
    
    func fetchNextLaunch() {
        networkService.getNextLaunch { result in
            switch result {
            case .success(let nextLaunch):
                self.nextLaunch = nextLaunch
                self.viewDelegate?.didFetchNextLaunchWithSuccess()
            case .failure(let error):
                self.viewDelegate?.didFetchWithError(message: error.rawValue)
            }
        }
    }
}
