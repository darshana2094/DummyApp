//
//  ErrorLoadingState.swift
//  DummyApp
//
//  Created by Darshana Nagekar on 03/02/25.
//

import Foundation

struct ErrorLoadingState {
    var isLoading: Bool = false
    var isSuccess: Bool = false
    var errorMessage: String?
    mutating func updateLoadingState(isLoading: Bool, errorMessage: String? = nil,isSuccess: Bool) {
        self.isLoading = isLoading
        self.errorMessage = errorMessage
        self.isSuccess = isSuccess
    }
}
