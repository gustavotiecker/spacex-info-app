//
//  NetworkServiceSpy.swift
//  SpaceXInfoTests
//
//  Created by Gustavo Tiecker on 05/04/22.
//

import XCTest
@testable import SpaceXInfo

final class NetworkServiceSpy: NetworkServiceProtocol {
    
    private(set) var requestCalled = false
    private(set) var completionPassed: Any?
    
    var resultToBeReturned: Any?
    
    func getUpcomingLaunches(completion: @escaping ((Result<[Launch], APIError>) -> Void)) {
        
    }
    
    func getRockets(completion: @escaping ((Result<[Rocket], APIError>) -> Void)) {
    }
    
    func getLatestLaunch(completion: @escaping (Result<Launch, APIError>) -> Void) {
        self.requestCalled = true
        self.completionPassed = completion
        
        if let resultToBeReturned = resultToBeReturned {
           completion(resultToBeReturned as! Result<Launch, APIError>)
        } else {
            completion(.failure(.unableToComplete))
        }
    }
    
    func getNextLaunch(completion: @escaping (Result<Launch, APIError>) -> Void) {
        self.requestCalled = true
        self.completionPassed = completion
        
        if let resultToBeReturned = resultToBeReturned {
           completion(resultToBeReturned as! Result<Launch, APIError>)
        } else {
            completion(.failure(.unableToComplete))
        }
    }
}
