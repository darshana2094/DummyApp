//
//  MockUserRepository.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 18/02/25.
//

import XCTest
import Combine
@testable import DummyApp

final class MockUserRepository: UserRepositoryProtocol {
    
    var result: Result<[UserModel], Error>?
    
    func fetchAllUsers() -> AnyPublisher<[UserModel], Error> {
        guard let result = result else {
            fatalError("MockUserRepository Error")
        }
        return result.publisher.eraseToAnyPublisher()
    }
}

