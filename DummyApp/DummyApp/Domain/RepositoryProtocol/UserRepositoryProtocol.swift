//
//  Repository.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 05/02/25.
//

import Foundation
import Combine

// Protocol that defines the method for a user repository.
// This allows for fetching all users as a list of `User` objects.
protocol UserRepositoryProtocol {
    
    // Asynchronously fetches all users and returns a publisher that emits an array of `User` objects or an error.
    func fetchAllUsers() -> AnyPublisher<[UserModel], Error>
}

