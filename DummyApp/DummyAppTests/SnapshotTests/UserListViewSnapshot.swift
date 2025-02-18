//
//  UserListViewSnapshot.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 11/02/25.
//

import SnapshotTesting
import XCTest
import SwiftUI
import Combine
@testable import DummyApp

final class UserListViewTests: XCTestCase {
    
    let mockViewModel = UserListViewModel(userUseCase: MockUsersUseCase())

    func testUserListView() {
        
        let users = [UserModel(
            id:1,
            firstName: "Darshana",
            lastName: "Nagekar",
            email: "dn@example.com",
            address: AddressModel(
                address: "1158",
                city: "Ghotmorad",
                state: "Goa",
                postalCode: "403706"
            ), company: CompanyModel(name: "Apple")),
                     UserModel(
                        id: 2,
                        firstName: "D",
                        lastName: "N",
                        email: "nd@example.com",
                        address: AddressModel(
                            address: "115",
                            city: "Margao",
                            state: "Goa",
                            postalCode: "403705"
                        ),
                        company: CompanyModel(name: "Google")
                     ),
                     UserModel(
                        id: 3,
                        firstName: "D",
                        lastName: "N",
                        email: "nd@example.com",
                        address: AddressModel(
                            address: "115",
                            city: "Margao",
                            state: "Goa",
                            postalCode: "403705"
                        ),
                        company: CompanyModel(name: "Google")
                     ),
                     UserModel(
                        id: 4,
                        firstName: "DD",
                        lastName: "NN",
                        email: "nd@example.com",
                        address: AddressModel(
                            address: "115",
                            city: "Panjim",
                            state: "Goa",
                            postalCode: "403708"
                        ),
                        company: CompanyModel(name: "Microsoft")
                     ),
                     UserModel(
                        id: 5,
                        firstName: "DD",
                        lastName: "NN",
                        email: "nd@example.com",
                        address: AddressModel(
                            address: "115",
                            city: "Panjim",
                            state: "Goa",
                            postalCode: "403708"
                        ),
                        company: CompanyModel(name: "Microsoft")
                     ),
                     UserModel(
                        id: 6,
                        firstName: "DDD",
                        lastName: "NNN",
                        email: "ndd@example.com",
                        address: AddressModel(
                            address: "115",
                            city: "Panjim",
                            state: "Goa",
                            postalCode: "403708"
                        ),
                        company: CompanyModel(name: "Microsoft")
                     ),
                     UserModel(
                        id: 7,
                        firstName: "Darsh",
                        lastName: "NNN",
                        email: "ndn@example.com",
                        address: AddressModel(
                            address: "115",
                            city: "Panjim",
                            state: "Goa",
                            postalCode: "403708"
                        ),
                        company: CompanyModel(name: "Microsoft")
                     )
        ]
        
        mockViewModel.users = users
        mockViewModel.showProgessView = false
        let userListView = UserListView(userListViewModel: self.mockViewModel)
        
        assertSnapshot(of: userListView, as: .image)
    
    }
}

