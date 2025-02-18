//
//  MockEndPoint.swift
//  DummyAppTests
//
//  Created by Darshana Nagekar on 04/01/25.
//

import Foundation
@testable import DummyApp

public enum BaseURLType {
    case validBaseURL
    case invalidBaseURL
}

public enum MockEndPoint {
    case users(baseURLType: BaseURLType)
    case dummyUsers(baseURLType: BaseURLType)
    case invalidUrl(baseURLType: BaseURLType)
}

struct MockNetworkConstant {
    static let baseUrl = "https://dummyjson.com"
    static let invalidBaseUrl = "https://invalidBaseUrl.com"
    static let users = "users"
    static let dummyUsers = "products"
    static let invalid = "invalid"
}

extension MockEndPoint: EndPointType {
    
    public var requestBody: Data? {
            switch self {
            case .users,.dummyUsers,.invalidUrl:
                return nil
            }
        }
    
    public var baseURL: URL {
        switch self {
        case .users(let baseURLType), .dummyUsers(let baseURLType), .invalidUrl(let baseURLType):
            switch baseURLType {
            case .validBaseURL:
                guard let url = URL(string: MockNetworkConstant.baseUrl) else {
                    fatalError("baseURL could not be configured.")
                }
                return url
            case .invalidBaseURL:
                guard let url = URL(string: MockNetworkConstant.invalidBaseUrl) else {
                    fatalError("baseURL2 could not be configured.")
                }
                return url
            }
        }
    }

    public var path: String {
        switch self {
        case .users:
            return MockNetworkConstant.users
        case .dummyUsers:
            return MockNetworkConstant.dummyUsers
        case .invalidUrl:
            return MockNetworkConstant.invalid
        }
    }

    public var httpMethod: HTTPMethod {
        switch self {
        case .users,.dummyUsers,.invalidUrl:
            return .get
        }
    }

    public var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }

    public var headers: HTTPHeaders? {
        return nil
    }
}



