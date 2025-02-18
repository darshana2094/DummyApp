//
//  UserDetailCardTest.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 05/01/25.
//


import XCTest
import SnapshotTesting
import SwiftUI
@testable import DummyApp


final class UserDetailsCardSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testUserDetailsCardRendering() {
       
        let user = UserModel(
            id:1,
            firstName: "Darshana",
            lastName: "Nagekar",
            email: "dn@example.com",
            address: AddressModel(
                address: "1158",
                city: "Ghotmorad",
                state: "Goa",
                postalCode: "403706"
            ),
            company: CompanyModel(name: "Apple")
        )
        
        let view = UserDetailsCard(user: user).frame(width: 350, height: 200)
        
        let viewController: UIView = UIHostingController(rootView: view).view
        
        assertSnapshot(of: viewController, as: .image)
    }
}
