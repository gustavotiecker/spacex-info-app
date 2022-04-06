//
//  HomeViewModelTests.swift
//  SpaceXInfoTests
//
//  Created by Gustavo Tiecker on 05/04/22.
//

import XCTest
@testable import SpaceXInfo

class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!
    private var networkServiceSpy: NetworkServiceSpy!
    
    var didFetchLatestLaunchWithSuccessCalled: ((Bool) -> (Void))?
    var didFetchNextLaunchWithSuccessCalled: ((Bool) -> (Void))?
    var didFetchWithErrorCalled: ((String) -> (Void))?
    
    let customTimeout: TimeInterval = 5.0
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel()
        networkServiceSpy = NetworkServiceSpy()
        sut.networkService = networkServiceSpy
        sut.viewDelegate = self
    }
    
    override func tearDown() {
        networkServiceSpy = nil
    }
    
    func test_getLatestLaunch_shouldReturnCorrectData_afterFetchLatestLaunchIsCalled() {
        // Given
        networkServiceSpy.resultToBeReturned = Result<Launch, APIError>.success(Launch.fixture(missionName: "Apollo"))
        
        // When
        sut.fetchLatestLaunch()
        
        // Then
        XCTAssertTrue(networkServiceSpy.requestCalled)
        XCTAssertNotNil(networkServiceSpy.completionPassed)
        XCTAssertEqual(sut.getLatestLaunch()?.missionName, "Apollo")
    }
    
    func test_getNextLaunch_shouldReturnCorrectData_afterFetchNextLaunchIsCalled() {
        // Given
        networkServiceSpy.resultToBeReturned = Result<Launch, APIError>.success(Launch.fixture(missionName: "Apollo"))
        
        // When
        sut.fetchNextLaunch()
        
        // Then
        XCTAssertTrue(networkServiceSpy.requestCalled)
        XCTAssertNotNil(networkServiceSpy.completionPassed)
        XCTAssertEqual(sut.getNextLaunch()?.missionName, "Apollo")
    }
    
    func test_didFetchWithError_ShouldBeCalled_AfterFetchLatestLaunchWithError() {
        networkServiceSpy.resultToBeReturned = Result<Launch, APIError>.failure(.unableToComplete)
        
        let expectation = XCTestExpectation(description: "Should call didFetchLatestLaunchWithSuccessCalled")
        didFetchWithErrorCalled = { message in
            XCTAssertNotNil(message)
            XCTAssertEqual(message, "Unable to complete your request. Please check your internet connection.")
            expectation.fulfill()
        }
        sut.fetchLatestLaunch()
        self.wait(for: [expectation], timeout: customTimeout)
    }
    
    func test_didFetchWithError_ShouldBeCalled_AfterFetchNextLaunchWithError() {
        networkServiceSpy.resultToBeReturned = Result<Launch, APIError>.failure(.unableToComplete)
        
        let expectation = XCTestExpectation(description: "Should call didFetchLatestLaunchWithSuccessCalled")
        didFetchWithErrorCalled = { message in
            XCTAssertNotNil(message)
            XCTAssertEqual(message, "Unable to complete your request. Please check your internet connection.")
            expectation.fulfill()
        }
        sut.fetchNextLaunch()
        self.wait(for: [expectation], timeout: customTimeout)
    }
    
    // MARK: - Testing with real service
    func test_didFetchLatestLaunchWithSuccess_ShouldBeCalled_AfterFetchLatestLaunch() {
        sut.networkService = NetworkService()
        let expectation = XCTestExpectation(description: "Should call didFetchLatestLaunchWithSuccessCalled")
        didFetchLatestLaunchWithSuccessCalled = { result in
            XCTAssertTrue(result)
            expectation.fulfill()
        }
        sut.fetchLatestLaunch()
        self.wait(for: [expectation], timeout: customTimeout)
    }
    
    func test_didFetchNextLaunchWithSuccess_ShouldBeCalled_AfterFetchNextLaunch() {
        sut.networkService = NetworkService()
        let expectation = XCTestExpectation(description: "Should call didFetchNextLaunchWithSuccessCalled")
        didFetchNextLaunchWithSuccessCalled = { result in
            XCTAssertTrue(result)
            expectation.fulfill()
        }
        sut.fetchNextLaunch()
        self.wait(for: [expectation], timeout: customTimeout)
    }
}

extension HomeViewModelTests: HomeViewDelegate {
    func didFetchLatestLaunchWithSuccess() {
        didFetchLatestLaunchWithSuccessCalled?(true)
    }
    
    func didFetchNextLaunchWithSuccess() {
        didFetchNextLaunchWithSuccessCalled?(true)
    }
    
    func didFetchWithError(message: String) {
        didFetchWithErrorCalled?(message)
    }
}
