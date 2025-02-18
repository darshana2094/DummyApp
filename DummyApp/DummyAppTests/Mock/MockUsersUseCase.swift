//
//  File.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 06/01/25.
//

import XCTest
import Combine
@testable import DummyApp

// Mock class conforming to the UsersUseCaseProtocol
final class MockUsersUseCase: UsersUseCaseProtocol {
    
    // MARK: - Properties
    
    var result: Result<[UserModel], Error> = .success([])
    
    // MARK: - Methods
    
    /// Executes the use case to fetch a list of users in the mock.
    ///
    /// This method will return the mock result set in `mockFetchResult`.
    ///
    /// - Returns: A publisher that emits either a success or failure based on the mock result.
    func execute() -> AnyPublisher<[UserModel], Error> {
      
            switch result {
            case .success(let users):
                return Just(users)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
    }
}


