//
//  UserDataModel.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 10/02/25.
//

import Foundation

// MARK: - UserDataResponse

struct UserDataResponse: Decodable {
    let users: [UserDataModel]
}

struct UserDataModel: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let address: AddressDataModel
    let company: CompanyDataModel
}

// MARK: - AddressDataModel
struct AddressDataModel: Decodable {
    let address: String
    let city: String
    let state: String
    let postalCode: String
}

// MARK: - CompanyDataModel
struct CompanyDataModel: Decodable {
    let name: String
}
