//
//  DummyAppApp.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 18/02/25.
//

import SwiftUI

@main
struct DummyApp: App {
    
    init() {}
    var body: some Scene {
        WindowGroup {
            UserListView(userListViewModel: UserListViewModel(userUseCase:UsersUseCase(userRepository: UserRepositoryImpl(networkingProtocol: NetworkManager()))))
        }
    }
}
