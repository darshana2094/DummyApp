//
//  Untitled.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 03/02/25.
//

import Foundation


// MARK: - UserResponse
struct UserResponse {
    
    let users: [UserModel]

}

// MARK: - User
struct UserModel: Identifiable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let address: AddressModel
    let company: CompanyModel
}

// MARK: - Address
struct AddressModel: Equatable {
    let address: String
    let city: String
    let state: String
    let postalCode: String
}

// MARK: - Company
struct CompanyModel: Equatable {
    let name: String
}

