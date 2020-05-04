//
//  SignInViewModel.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

protocol SignInViewModelType {
    func isPasswordValid(_ password: String?) -> Bool
    func isUsernameValid(_ username: String?) -> Bool
    func signIn(username: String, password: String)
    func signUp()
}

class SignInViewModel: SignInViewModelType {
    func isPasswordValid(_ password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        return !password.isEmpty
    }

    func isUsernameValid(_ username: String?) -> Bool {
        guard let username = username else {
            return false
        }
        return !username.isEmpty
    }

    func signIn(username: String, password: String) {
    }

    func signUp() {
    }
}
