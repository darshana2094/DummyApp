//
//  Mapper.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 17/02/25.
//

import XCTest
@testable import DummyApp

final class UserMapperTest: XCTestCase {

    // MARK: - User Mapper Test
    func test_UserMapper_ShouldMapUserDataModelToUserModel() {
        // Given
        let addressDataModel = AddressDataModel(address: "Ghotmorad", city: "Curchorem", state: "Goa", postalCode: "403706")
        let companyDataModel = CompanyDataModel(name: "Apple")
        let userDataModel = UserDataModel(id: 1, firstName: "D", lastName: "N", email: "d.nn@example.com", address: addressDataModel, company: companyDataModel)
        
        // When
        let userModel = UserMapper.map(userDataModel)

        // Then
        XCTAssertEqual(userModel.id, 1)
        XCTAssertEqual(userModel.firstName, "D")
        XCTAssertEqual(userModel.lastName, "N")
        XCTAssertEqual(userModel.email, "d.nn@example.com")
        
        // Address Mapping
        XCTAssertEqual(userModel.address.address, "Ghotmorad")
        XCTAssertEqual(userModel.address.city, "Curchorem")
        XCTAssertEqual(userModel.address.state, "Goa")
        XCTAssertEqual(userModel.address.postalCode, "403706")
        
        // Company Mapping
        XCTAssertEqual(userModel.company.name, "Apple")
    }

    // MARK: - Address Mapper Test
    func test_AddressMapper_ShouldMapAddressDataModelToAddressModel() {
        // Given
        let addressDataModel = AddressDataModel(address: "Quepem", city: "Curchorem", state: "Goa", postalCode: "403706")
        
        // When
        let addressModel = AddressMapper.map(from: addressDataModel)

        // Then
        XCTAssertEqual(addressModel.address, "Quepem")
        XCTAssertEqual(addressModel.city, "Curchorem")
        XCTAssertEqual(addressModel.state, "Goa")
        XCTAssertEqual(addressModel.postalCode, "403706")
    }

    // MARK: - Company Mapper Test
    func test_CompanyMapper_ShouldMapCompanyDataModelToCompanyModel() {
        // Given
        let companyDataModel = CompanyDataModel(name: "Apple")
        
        // When
        let companyModel = CompanyMapper.map(from: companyDataModel)

        // Then
        XCTAssertEqual(companyModel.name, "Apple")
    }
}
