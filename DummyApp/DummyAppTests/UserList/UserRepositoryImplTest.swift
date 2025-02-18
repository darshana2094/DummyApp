//
//  UserRepositoryUnitTest.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 18/02/25.
//

import XCTest
import Combine
@testable import DummyApp

final class UserRepositoryImplTest:XCTestCase {
    
    var sut: UserRepositoryImpl!
    var cancellables: Set<AnyCancellable>!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()

        mockNetworkManager = MockNetworkManager()
        sut = UserRepositoryImpl(networkingProtocol: mockNetworkManager)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    //MARK: Fetch Users Success Test
    func testFetchAllUsers_Success() {
        // Given
        let usersResponse = UserDataResponse(users: [
            UserDataModel(id: 1, firstName: "Darshana",lastName: "Nagekar",email: "dn@example.com", address: AddressDataModel(address: "1158", city: "Ghotmorad",state:"Goa",postalCode: "403706"), company: CompanyDataModel(name: "Apple")),
            UserDataModel(id: 2, firstName: "Darsh",lastName:"N", email: "nd@example.com", address: AddressDataModel(address: "1111", city: "Margao", state:"Goa", postalCode: "94101"), company: CompanyDataModel(name: "Google"))
        ])
        
        mockNetworkManager.result = .success(usersResponse)
        
        //When
        let expectation = XCTestExpectation(description: "Fetch users")
        
        //Then
        sut.fetchAllUsers()
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { users in
                
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users.first?.id, 1)
                XCTAssertEqual(users.first?.firstName, "Darshana")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
          wait(for: [expectation], timeout: 5.0)
    }
    
    //MARK: Fetch Users Failure Test
    func test_FetchAllUsers_Failure() {
        
        // Given
        let error = NSError(domain: "", code: 0, userInfo: nil)
        mockNetworkManager.result = .failure(error)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch users failure")
        var receivedError: Error?
        
        //Then
        sut.fetchAllUsers()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                    XCTAssertNotNil(receivedError)
                    expectation.fulfill()
                }
            }, receiveValue: { users in
                XCTFail("Expected error,but received users: \(users)")
            }).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}


