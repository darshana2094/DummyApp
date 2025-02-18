//
//  ContentView.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 03/02/25.
//

import SwiftUI


/// A SwiftUI view that displays a list of users and handles various states such as loading, errors, and network availability.
///
/// This view integrates with `UserListViewModel` to fetch and display user data.
/// It provides different UI elements for loading, empty state, and error handling scenarios.
struct UserListView<UserListViewModel>: View where UserListViewModel: UserListViewModelProtocol {
    
    // MARK: - Properties
    
    /// The view model responsible for managing user data and state.
    @StateObject var userListViewModel: UserListViewModel
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `UserListView`.
    ///
    /// - Parameter userListViewModel: A view model conforming to `UserListViewModelProtocol` for managing user data and state.
    init(userListViewModel: UserListViewModel) {
        _userListViewModel = StateObject(wrappedValue: userListViewModel)
    }
    
    // MARK: - Body
    
    /// The body of the `UserListView`, providing the main layout and navigation setup.
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(StringConstants.navigationBarTitle)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    if userListViewModel.users == nil && userListViewModel.loadingState.errorMessage == nil {
                        userListViewModel.getUsers()
                    }
                }
        }
    }
    
    // MARK: - Content
    
    /// The main content of the view, conditionally displaying different UI elements based on the current state.
    @ViewBuilder private var content: some View {
        if userListViewModel.loadingState.isLoading || userListViewModel.showProgessView {
            progressView().accessibilityIdentifier(StringConstants.accessiblityTextForIndicator)
        } else {
            userListView
        }
    }
    
    // MARK: - User List View
    
    /// The view displaying the list of users or appropriate placeholder views for empty or error states.
    private var userListView: some View {
        Group {
            if let users = userListViewModel.users {
                if users.isEmpty {
                    contentUnavailableView(
                        title: StringConstants.noUserFoundText,
                        imageName: "person.slash",
                        subTitle: ""
                    )
                } else {
                    List(users, id: \.id) { user in
                        NavigationLink(destination: UserDetailsCard(user: user)) {
                            UserRowItem(user: user)
                        }
                    }
                    .listStyle(.inset)
                    .accessibilityIdentifier(StringConstants.accessiblityTextForLisView)
                }
            } else if userListViewModel.loadingState.isSuccess == false {
                
                
                contentUnavailableView(
                    title: StringConstants.somethingWentWrongText,
                    imageName: "exclamationmark.circle.fill",
                    subTitle: StringConstants.pleaseTryAgainTexr
                )
            }
        }
    }
    
    // MARK: - Progress View
    
    /// A view displaying a circular progress indicator.
    ///
    /// - Returns: A `ProgressView` styled with a circular indicator and custom scaling.
    private func progressView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .scaleEffect(1.5)
            .padding(20)
    }
    
    // MARK: - Content Unavailable View
    
    /// A reusable view for displaying placeholder content when the user list is unavailable.
    ///
    /// - Parameters:
    ///   - title: The title text to display.
    ///   - imageName: The system image name to display.
    ///   - subTitle: The subtitle text to display.
    /// - Returns: A `ContentUnavailableView` with provided content and actions.
    private func contentUnavailableView(title: String, imageName: String, subTitle: String) -> some View {
        ContentUnavailableView {
            Label(title, systemImage: imageName)
        } description: {
            Text(subTitle)
        } actions: {
            Button(StringConstants.refreshButtonText) {
                userListViewModel.getUsers()
            }
        }
    }
}
