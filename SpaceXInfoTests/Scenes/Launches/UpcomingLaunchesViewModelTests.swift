//
//  UpcomingLaunchesViewModelTests.swift
//  SpaceXInfoTests
//
//  Created by Gustavo Tiecker on 06/04/22.
//

import XCTest
@testable import SpaceXInfo

class UpcomingLaunchesViewModelTests: XCTestCase {
    
    private var sut: UpcomingLaunchesViewModel!
    private var networkServiceSpy: NetworkServiceSpy!
    
    var didFetchUpcomingLaunchesWithSuccessCalled: ((Bool) -> (Void))?
    var didFetchUpcomingLaunchesWithErrorCalled: ((String) -> (Void))?
    
    let customTimeout: TimeInterval = 5.0
    
    override func setUp() {
        super.setUp()
        sut = UpcomingLaunchesViewModel()
        networkServiceSpy = NetworkServiceSpy()
        sut.networkService = networkServiceSpy
        sut.viewDelegate = self
    }
    
    override func tearDown() {
        networkServiceSpy = nil
    }
    
    // MARK: - TableView Configuration
    func test_getNumberOfRows_ShouldReturnUpcomingLaunchesCount() {
        networkServiceSpy.resultToBeReturned = Result<[Launch], APIError>.success([Launch.fixture()])
        
        sut.fetchUpcomingLaunches()
        
        XCTAssertEqual(sut.getNumberOfRows(), 1)
    }
    
    func test_getLaunch_ShouldReturnCorrectLaunchAtIndexPath() {
        networkServiceSpy.resultToBeReturned = Result<[Launch], APIError>.success([Launch.fixture(missionName: "Apollo")])
        
        sut.fetchUpcomingLaunches()
        
        XCTAssertEqual(sut.getLaunch(at: IndexPath(row: 0, section: 0)).missionName, "Apollo")
    }
    
    // MARK: - Network
    func test_didFetchUpcomingLaunchesWithError_ShouldBeCalled_AfterFetchUpcomingLaunchesWithError() {
        networkServiceSpy.resultToBeReturned = Result<[Launch], APIError>.failure(.unableToComplete)
        
        let expectation = XCTestExpectation(description: "Should call didFetchLatestLaunchWithSuccessCalled")
        didFetchUpcomingLaunchesWithErrorCalled = { message in
            XCTAssertNotNil(message)
            XCTAssertEqual(message, "Unable to complete your request. Please check your internet connection.")
            expectation.fulfill()
        }
        sut.fetchUpcomingLaunches()
        self.wait(for: [expectation], timeout: customTimeout)
    }
    
    func test_didFetchUpcomingLaunchesWithSuccess_ShouldBeCalled_AfterFetchUpcomingLaunchesIsCalled() {
        sut.networkService = NetworkService()
        let expectation = XCTestExpectation(description: "Should call didFetchLatestLaunchWithSuccessCalled")
        didFetchUpcomingLaunchesWithSuccessCalled = { result in
            XCTAssertTrue(result)
            expectation.fulfill()
        }
        sut.fetchUpcomingLaunches()
        self.wait(for: [expectation], timeout: customTimeout)
    }
}

extension UpcomingLaunchesViewModelTests: UpcomingLaunchesViewDelegate {
    func didFetchUpcomingLaunchesWithSuccess() {
        didFetchUpcomingLaunchesWithSuccessCalled?(true)
    }
    
    func didFetchUpcomingLaunchesWithError(message: String) {
        didFetchUpcomingLaunchesWithErrorCalled?(message)
    }
}
