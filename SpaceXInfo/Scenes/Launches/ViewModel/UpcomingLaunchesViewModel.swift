//
//  UpcomingLaunchesViewModel.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 04/04/22.
//

import Foundation

protocol UpcomingLaunchesBusinessLogic {
    // MARK: - TableView Configuration
    func getNumberOfRows() -> Int
    func getLaunch(at indexPath: IndexPath) -> Launch
    
    // MARK: - Network
    func fetchUpcomingLaunches()
}

protocol UpcomingLaunchesViewDelegate: AnyObject {
    func didFetchUpcomingLaunchesWithSuccess()
    func didFetchUpcomingLaunchesWithError(message: String)
}

final class UpcomingLaunchesViewModel {
    
    // MARK: - Properties
    private var launches: [Launch] = []
    var networkService: NetworkServiceProtocol = NetworkService()
    weak var viewDelegate: UpcomingLaunchesViewDelegate?
}

extension UpcomingLaunchesViewModel: UpcomingLaunchesBusinessLogic {
    
    func getNumberOfRows() -> Int {
        return launches.count
    }
    
    func getLaunch(at indexPath: IndexPath) -> Launch {
        return launches[indexPath.row]
    }
    
    // MARK: - Network
    func fetchUpcomingLaunches() {
        networkService.getUpcomingLaunches { result in
            switch result {
            case .success(let launches):
                self.launches = launches
                self.viewDelegate?.didFetchUpcomingLaunchesWithSuccess()
            case .failure(let error):
                self.viewDelegate?.didFetchUpcomingLaunchesWithError(message: error.rawValue)
            }
        }
    }
}
