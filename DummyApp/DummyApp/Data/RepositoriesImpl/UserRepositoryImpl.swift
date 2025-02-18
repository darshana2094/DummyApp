//
//  UsersRepository.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 04/01/25.
//

import Foundation
import Combine


final class UserRepositoryImpl: UserRepositoryProtocol {
   
    //MARK: Properties
    private var networkingProtocol: NetworkingProtocol
    
    //MARK: Initializer
    init(networkingProtocol: NetworkingProtocol) {
        self.networkingProtocol = networkingProtocol
    }
    
    //MARK: Method to fetch all users
    
    func fetchAllUsers() -> AnyPublisher<[UserModel], any Error> {
        networkingProtocol.request(endPoint: UserApi.users)
            .receive(on: DispatchQueue.main)
            .map { (response:UserDataResponse) in
                return response.users.map{UserMapper.map($0)}
            }
            .eraseToAnyPublisher()
            
    }
}
  

