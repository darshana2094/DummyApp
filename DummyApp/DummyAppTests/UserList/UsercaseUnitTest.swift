//
//  UsercaseUnitTest.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 17/02/25.
//

import XCTest
import Combine
@testable import DummyApp

final class UsersUseCaseUnitTest: XCTestCase {
    
    var sut: UsersUseCase!
    var cancellables: Set<AnyCancellable>!
    var mockUserRepository: MockUserRepository!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockUserRepository = MockUserRepository()
        sut = UsersUseCase(userRepository: mockUserRepository)
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        mockUserRepository = nil
        super.tearDown()
    }
    
    //MARK: Fetch Users Success Test
    func test_FetchAllUsers_Success() {
        
        // Given
        let usersResponse = UserDataResponse(users: [
            UserDataModel(id: 1, firstName: "Darshana",lastName: "Nagekar",email: "dn@example.com", address: AddressDataModel(address: "1158", city: "Ghotmorad",state:"Goa",postalCode: "403706"), company: CompanyDataModel(name: "Apple")),
            UserDataModel(id: 2, firstName: "Darsh",lastName:"N", email: "nd@example.com", address: AddressDataModel(address: "1111", city: "Margao", state:"Goa", postalCode: "94101"), company: CompanyDataModel(name: "Google"))
        ])
        
        let mappedUsers = usersResponse.users.map { UserMapper.map($0) }
        mockUserRepository.result = .success(mappedUsers)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch users")
        var receivedError: Error?
        
        // Then
        sut.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                    XCTFail("Expected response,but received error: \(String(describing: receivedError))")
                }
                
            }, receiveValue: { users in
                XCTAssertNil(receivedError)
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users.first?.firstName, "Darshana")
                expectation.fulfill()
            }).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    //MARK: Fetch Users Failure Test
    func test_FetchAllUsers_Failure() {
        
        // Given
        let error = NSError(domain: "", code: 0, userInfo: nil)
        mockUserRepository.result = .failure(error)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch users failure")
        var receivedError: Error?
        
        // Then
        sut.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                    XCTAssertNotNil(receivedError)
                    expectation.fulfill()
                }
            }, receiveValue: { users in
                XCTFail("Expected error,but received response: \(users)")
            }).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
