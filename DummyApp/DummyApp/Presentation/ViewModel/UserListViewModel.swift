//
//  UserListViewModel.swift
//  DummyProject
//
//  Created by Darshana Nagekar on 03/02/25.
//

import SwiftUI
import Combine

/// This class is designed to be used in SwiftUI views as an `ObservableObject`.
/// It interacts with the use case layer to fetch user data and provides state information to the UI.
///
protocol UserListViewModelProtocol: ObservableObject {
    var loadingState: ErrorLoadingState { get set }
    var showProgessView: Bool { get set }
    var users: [UserModel]? { get }
    func getUsers()
    func handleCompletion(_ completion: Subscribers.Completion<Error>)
    func handleUserResponse(_ users: [UserModel])
    func resetLoadingState()
}

final class UserListViewModel: UserListViewModelProtocol {
    
    // MARK: - Published Properties
    
    /// The list of users fetched from the use case.
    @Published var users: [UserModel]?
    
    /// The loading state, encapsulating information about the current loading status, errors, and success.
    @Published var loadingState = ErrorLoadingState()
    
    // MARK: - Private Properties
    
    /// The use case responsible for fetching users.
    private var userUseCase: UsersUseCaseProtocol
    
    /// A set of cancellables for managing Combine subscriptions related to login responses.
    private var loginSubscription = Set<AnyCancellable>()
    
    /// This is to handling displaying of the progress view
    @Published var showProgessView: Bool = true
    
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `UserListViewModel`.
    ///
    /// - Parameter userUseCase: An instance conforming to `UsersUseCaseProtocol` for handling user fetching logic.
    init(userUseCase: UsersUseCaseProtocol) {
        self.userUseCase = userUseCase
     
    }
    
    // MARK: - Methods
    
    /// Fetches the list of users from the use case.
    ///
    /// This method updates the `loadingState` to reflect the current status of the request.
    /// It checks for network connectivity before attempting to fetch users and handles
    /// both success and failure scenarios.
    func getUsers() {
        self.loadingState.updateLoadingState(isLoading: true, isSuccess: false)
        
        userUseCase.execute()
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] returnedLoginResponse in
                self?.handleUserResponse(returnedLoginResponse)
            }
            .store(in: &loginSubscription)
    }
    
    /// Handles the completion of the Combine publisher from the use case.
    ///
    /// - Parameter completion: A `Subscribers.Completion` instance indicating success or failure.
    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        showProgessView = false
        switch completion {
        case .finished:
            self.loadingState.updateLoadingState(isLoading: false, isSuccess: true)
        case .failure(let error):
            loadingState.updateLoadingState(isLoading: false, errorMessage: error.localizedDescription, isSuccess: false)
        }
    }
    
    /// Handles the response containing a list of users.
    ///
    /// - Parameter response: An array of `User` objects fetched from the use case.
    func handleUserResponse(_ users: [UserModel]) {
        self.users = users
        resetLoadingState()
    }
    
    /// Resets the loading state to its default values.
    func resetLoadingState() {
        loadingState.updateLoadingState(isLoading: false, errorMessage: nil, isSuccess: false)
        showProgessView = false
    }
}
