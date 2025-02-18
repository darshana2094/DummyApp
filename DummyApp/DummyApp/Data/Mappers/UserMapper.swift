//
//  UserMapper.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 10/02/25.
//

import Foundation

// MARK: - UserMapper
struct UserMapper {
    static func map(_ userDataModel: UserDataModel) -> UserModel {
        return UserModel(
            id: userDataModel.id,
            firstName: userDataModel.firstName,
            lastName: userDataModel.lastName,
            email: userDataModel.email,
            address: AddressMapper.map(from: userDataModel.address),
            company: CompanyMapper.map(from: userDataModel.company)
        )
    }
}

// MARK: - AddressMapper
struct AddressMapper {
    static func map(from userDataModel: AddressDataModel) -> AddressModel {
        return AddressModel(
            address: userDataModel.address,
            city: userDataModel.city,
            state: userDataModel.state,
            postalCode: userDataModel.postalCode
        )
    }
}

// MARK: - CompanyMapper
struct CompanyMapper {
    static func map(from userDataModel: CompanyDataModel) -> CompanyModel {
        return CompanyModel(name: userDataModel.name)
    }
}
