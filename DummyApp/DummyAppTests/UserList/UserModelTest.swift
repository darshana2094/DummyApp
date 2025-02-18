//
//  UserModelUnitTes.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 06/01/25.
//


import XCTest
@testable import DummyApp

final class UserModelTest: XCTestCase {
    
    // MARK: - Equatable Tests
    
    //MARK: User Equality Test
    func test_UserEquality() {
        let address =  AddressModel(address: "1158", city: "Ghotmorad", state: "Goa", postalCode: "403706")
      
        let company = CompanyModel(name: "Apple")
        
        let user1 = UserModel(id: 1, firstName: "Darshana",lastName:"Nagekar",email: "dn@example.com", address:address, company: company)
        
        let user2 = UserModel(id: 1, firstName: "Darshana",lastName:"Nagekar",email: "dn@example.com", address:address, company: company)
        
        let user3 = UserModel(id: 1, firstName: "D",lastName:"N",email: "nd@example.com", address:address, company: company)
        
        XCTAssertTrue(user1 == user2, "Users with identical properties should be equal.")
        XCTAssertFalse(user1 == user3, "Users with different properties should not be equal.")
    }
    
    //MARK: Address Equality Test
    func test_AddressEquality() {
        let address1 =  AddressModel(address: "1158", city: "Ghotmorad", state: "Goa", postalCode: "403706")
        let address2 =  AddressModel(address: "1158", city: "Ghotmorad", state: "Goa", postalCode: "403706")
        let address3 =  AddressModel(address: "1151", city: "Margao", state: "Goa", postalCode: "403706")
        
        XCTAssertTrue(address1 == address2)
        XCTAssertFalse(address1 == address3)
    }
    
    //MARK: Company Equality Test
    func test_CompanyEquality() {
        let company1 = CompanyModel(name: "Apple")
        let company2 = CompanyModel(name: "Apple")
        let company3 = CompanyModel(name: "Google")
        
        XCTAssertTrue(company1 == company2)
        XCTAssertFalse(company1 == company3)
    }
    
    // MARK: - User Decodable Test
    func test_UserDecoding() {
        // Given
        let decoder = JSONDecoder()
        
        let mockUserData = """
        {
          "users": [
            {
              "id": 1,
              "firstName": "Darshana",
              "lastName": "Nagekar",
              "email": "dn@example.com",
              "address": {
                "address": "1158",
                "city": "Ghotmorad",
                "state": "Goa",
                "postalCode": "403706"
              },
              "company": {
                "name": "Apple"
              }
            }
          ]
        }
        """.data(using: .utf8)!
        
        do {
            // When
            let userList = try decoder.decode(UserDataResponse.self, from: mockUserData)
            let user = userList.users.first!
            
            // Then
            XCTAssertEqual(user.id, 1)
            XCTAssertEqual(user.firstName, "Darshana")
            XCTAssertEqual(user.lastName, "Nagekar")
            XCTAssertEqual(user.email, "dn@example.com")
            XCTAssertEqual(user.address.address, "1158")
            XCTAssertEqual(user.address.city, "Ghotmorad")
            XCTAssertEqual(user.address.state, "Goa")
            XCTAssertEqual(user.address.postalCode, "403706")
            XCTAssertEqual(user.company.name, "Apple")
        } catch {
            XCTFail("User decoding failed with error: \(error)")
        }
    }

    //MARK: Address Decoding Test
    func test_AddressDecoding() {
        // Given
        let jsonData = """
        {
        "address": "1158",
        "city": "Ghotmorad",
        "state": "Goa",
        "postalCode": "403706"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let address = try decoder.decode(AddressDataModel.self, from: jsonData)
            
            // Then
            XCTAssertEqual(address.address, "1158")
            XCTAssertEqual(address.city, "Ghotmorad")
            XCTAssertEqual(address.state, "Goa")
            XCTAssertEqual(address.postalCode, "403706")
        } catch {
            XCTFail("Address decoding failed with error: \(error)")
        }
    }

    //MARK: Company Decoding Test
    func test_CompanyDecoding() {
        // Given
        let jsonData = """
        {
            "name": "Apple"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When: Decoding the Company object
            let company = try decoder.decode(CompanyDataModel.self, from: jsonData)
            
            // Then: Verify the properties are correctly set
            XCTAssertEqual(company.name, "Apple")
        } catch {
            XCTFail("Company decoding failed with error: \(error)")
        }
    }
}
