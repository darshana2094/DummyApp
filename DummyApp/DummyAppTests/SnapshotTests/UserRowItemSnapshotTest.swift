//
//  Untitled.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 06/01/25.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import DummyApp

final class UserRowItemViewSnapshotTest: XCTestCase {
    
    var userItemRow:UserRowItem!

    override func setUpWithError() throws {
        try super.setUpWithError()
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
        userItemRow = UserRowItem(user:user)
    }
    
    override func tearDownWithError() throws {
     
        userItemRow = nil
        try super.tearDownWithError()
    }
    
    func testUserListViewSnapShot() {

        let view: UIView = UIHostingController(rootView: userItemRow).view
        
        assertSnapshot(
            of: view,
          as: .image(size: view.intrinsicContentSize)
        )
    }
}

