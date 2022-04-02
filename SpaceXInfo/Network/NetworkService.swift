//
//  NetworkService.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 02/04/22.
//

import UIKit

protocol NetworkServiceProtocol {
    func getUpcomingLaunches(completion: (@escaping (Result<[Launch], APIError>) -> Void))
    func getRockets(completion: (@escaping (Result<[Rocket], APIError>) -> Void))
}

final class NetworkService: NetworkServiceProtocol {
    
    func getUpcomingLaunches(completion: @escaping ((Result<[Launch], APIError>) -> Void)) {
        NetworkManager.shared.request(endPoint: .upcomingLaunches) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
                    let launches = try decoder.decode([Launch].self, from: data)
                    completion(.success(launches))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.unableToComplete))
            }
        }
    }
    
    func getRockets(completion: (@escaping (Result<[Rocket], APIError>) -> Void)) {
        NetworkManager.shared.request(endPoint: .rockets) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
                    let rockets = try decoder.decode([Rocket].self, from: data)
                    completion(.success(rockets))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.unableToComplete))
            }
        }
    }
}
