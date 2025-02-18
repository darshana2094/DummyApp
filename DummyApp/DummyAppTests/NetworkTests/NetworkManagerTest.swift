//
//  UserTest.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 04/01/25.
//

import XCTest
import Combine
@testable import DummyApp

final class NetworkManagerTest: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Test successful response
    
    var sut:NetworkManager!
    
    override func setUpWithError() throws {
        
        sut = NetworkManager()
    }
    
    //MARK: Successful Request Test
    func test_SuccessfulRequest() {
        // Given
        let expectation = XCTestExpectation(description: "Successful network request")
        // When
        sut.request(endPoint: MockEndPoint.users(baseURLType: .validBaseURL))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Handle failure, expecting error code 404
                    XCTFail("Expected success, got 404 error: \(error)")
                    expectation.fulfill() // Fulfill the expectation on failure
                }
            }, receiveValue: { (userResponse: UserDataResponse) in
                // Then
                XCTAssertNotNil(userResponse, "Successfully fetched user data")
                expectation.fulfill() // Fulfill the expectation on success
            })
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled with a timeout
        wait(for: [expectation], timeout: 5.0) // Timeout after 5 seconds
    }
    
    // MARK: - Test server error
    
    func test_ServerError() {
        
        // Given
        let expectation = XCTestExpectation(description: "Server error should be received")
        // When
        sut.request(endPoint: MockEndPoint.invalidUrl(baseURLType: .validBaseURL))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected error, but got success")
                    expectation.fulfill()
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error as? NetworkingError, NetworkingError.serverError(statusCode: 404))
                    expectation.fulfill()
                }
            }, receiveValue: { (userResponse: UserDataResponse) in
                XCTFail("Expected failure, but got user response: \(userResponse)")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    
    // MARK: - Test decoding error
    
    func test_DecodingError() {
        
        // Given
        let expectation = XCTestExpectation(description: "Decoding error should be received")
        
        // When
        sut.request(endPoint: MockEndPoint.dummyUsers(baseURLType: .validBaseURL))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected decoding error, but got success")
                    expectation.fulfill()
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error as? NetworkingError, NetworkingError.decodingError)
                    expectation.fulfill()
                    
                }
            }, receiveValue: { (userResponse: UserDataResponse) in
                XCTFail("Expected failure, but got user response: \(userResponse)")
                expectation.fulfill()
                
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Test Unknown Error
    
    func test_UnknownResponse() {
        // Given
        let expectation = XCTestExpectation(description: "Bad Request Response should be received")
        
        // When
        sut.request(endPoint: MockEndPoint.users(baseURLType: .invalidBaseURL))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected Unknown error, but got success")
                    expectation.fulfill()
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error as? NetworkingError, NetworkingError.unknown)
                    expectation.fulfill()
                }
            }, receiveValue: { (userResponse: UserDataResponse) in
                XCTFail("Expected failure, but got user response: \(userResponse)")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
