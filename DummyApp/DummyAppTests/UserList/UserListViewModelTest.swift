//
//  UserListTest.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 05/01/25.
//

import XCTest
import Combine
@testable import DummyApp

final class UserListViewModelTest: XCTestCase {
    
    var sut: UserListViewModel!
    var mockUserUseCase: MockUsersUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUserUseCase = MockUsersUseCase()
        sut = UserListViewModel(userUseCase: mockUserUseCase)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        mockUserUseCase = nil
        super.tearDown()
    }
    
    //MARK: Initial State Test
    
    func test_InitialState() {
        XCTAssertNil(sut.users)
        XCTAssertEqual(sut.loadingState.isLoading, false)
        XCTAssertEqual(sut.loadingState.isSuccess, false)
        XCTAssertNil(sut.loadingState.errorMessage)
    }
    
    //MARK: Get Users Success Test
    
    func test_GetUsers_Success() {
        
        //Given
        let mockUsers = [
            UserModel(id: 1, firstName: "Darshana",lastName: "Nagekar",email: "dn@example.com", address: AddressModel(address: "1158", city: "Ghotmorad",state:"Goa",postalCode: "403706"), company: CompanyModel(name: "Apple")),
            UserModel(id: 2, firstName: "Darsh",lastName:"N", email: "nd@example.com", address: AddressModel(address: "1111", city: "Margao", state:"Goa", postalCode: "94101"), company: CompanyModel(name: "Google"))
        ]
        mockUserUseCase.result = .success(mockUsers)
        
        //When
        sut.getUsers()
        
        //Then
        XCTAssertEqual(sut.users, mockUsers)
        XCTAssertEqual(sut.loadingState.isLoading, false)
        XCTAssertEqual(sut.loadingState.isSuccess, true)
        XCTAssertNil(sut.loadingState.errorMessage)
    }
    
    //MARK: Get Users Failure Test
    func test_GetUsers_Failure() {
        
        //Given
        let mockError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        mockUserUseCase.result = .failure(mockError)
        
        //When
        sut.getUsers()
        
        //Then
        XCTAssertNil(sut.users)
        XCTAssertEqual(sut.loadingState.isLoading, false)
        XCTAssertEqual(sut.loadingState.isSuccess, false)
        XCTAssertEqual(sut.loadingState.errorMessage, mockError.localizedDescription)
    }
    
    //MARK: Reset Loading State Test
    func test_ResetLoadingState() {
        // Given
        sut.loadingState.updateLoadingState(isLoading: true, isSuccess: false)
        
        // When
        sut.resetLoadingState()
        
        // Then
        XCTAssertEqual(sut.loadingState.isLoading, false)
        XCTAssertEqual(sut.loadingState.isSuccess, false)
        XCTAssertNil(sut.loadingState.errorMessage)
    }
}
