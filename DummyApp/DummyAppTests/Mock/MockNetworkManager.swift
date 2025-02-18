//
//  MockNetworkManager.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 17/02/25.
//

import XCTest
import Combine
@testable import DummyApp

final class MockNetworkManager: NetworkingProtocol {
    
    var result: Result<UserDataResponse, Error>?

    func request<T: Decodable>(endPoint: EndPointType) -> AnyPublisher<T, Error> {
        guard let result = result else {
            fatalError("MockUserRepository Error")
        }
        
        switch result {
        case .success(let users):
            guard let data = users as? T else {
                return Fail(error: NetworkingError.decodingError).eraseToAnyPublisher()
            }
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
