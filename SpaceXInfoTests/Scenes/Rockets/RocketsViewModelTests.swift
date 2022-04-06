//
//  RocketsViewModelTests.swift
//  SpaceXInfoTests
//
//  Created by Gustavo Tiecker on 06/04/22.
//

import XCTest
@testable import SpaceXInfo

class RocketsViewModelTests: XCTestCase {
    
    private var sut: RocketsViewModel!
    private var networkServiceSpy: NetworkServiceSpy!
    
    var didFetchRocketsWithSuccessCalled: ((Bool) -> (Void))?
    var didFetchRocketsWithErrorCalled: ((String) -> (Void))?
    
    let customTimeout: TimeInterval = 5.0
    
    override func setUp() {
        super.setUp()
        sut = RocketsViewModel()
        networkServiceSpy = NetworkServiceSpy()
        sut.networkService = networkServiceSpy
        sut.viewDelegate = self
    }
    
    override func tearDown() {
        networkServiceSpy = nil
    }
    
    // MARK: - TableView Configuration
    func test_getNumberOfRows_ShouldReturnRocketsCount() {
        networkServiceSpy.resultToBeReturned = Result<[Rocket], APIError>.success([Rocket.fixture()])
        
        sut.fetchRockets()
        
        XCTAssertEqual(sut.getNumberOfRows(), 1)
    }
    
    func test_getRocket_ShouldReturnCorrectRocketAtIndexPath() {
        networkServiceSpy.resultToBeReturned = Result<[Rocket], APIError>.success([Rocket.fixture(name: "Falcon 9")])
        
        sut.fetchRockets()
        
        XCTAssertEqual(sut.getRocket(at: IndexPath(row: 0, section: 0)).name, "Falcon 9")
    }
    
    // MARK: - Network
    func test_didFetchRocketsWithError_ShouldBeCalled_AfterFetchRocketsWithError() {
        networkServiceSpy.resultToBeReturned = Result<[Rocket], APIError>.failure(.unableToComplete)
        
        let expectation = XCTestExpectation(description: "Should call didFetchLatestLaunchWithSuccessCalled")
        didFetchRocketsWithErrorCalled = { message in
            XCTAssertNotNil(message)
            XCTAssertEqual(message, "Unable to complete your request. Please check your internet connection.")
            expectation.fulfill()
        }
        sut.fetchRockets()
        self.wait(for: [expectation], timeout: customTimeout)
    }
    
    func test_didFetchRocketsWithSuccess_ShouldBeCalled_AfterFetchRocketsIsCalled() {
        sut.networkService = NetworkService()
        let expectation = XCTestExpectation(description: "Should call didFetchLatestLaunchWithSuccessCalled")
        didFetchRocketsWithSuccessCalled = { result in
            XCTAssertTrue(result)
            expectation.fulfill()
        }
        sut.fetchRockets()
        self.wait(for: [expectation], timeout: customTimeout)
    }
}

extension RocketsViewModelTests: RocketsViewDelegate {
    func didFetchRocketsWithSuccess() {
        didFetchRocketsWithSuccessCalled?(true)
    }
    
    func didFetchRocketsWithError(message: String) {
        didFetchRocketsWithErrorCalled?(message)
    }
}
