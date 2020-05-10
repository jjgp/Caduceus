//
//  Actions.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import UIKit

enum AppActionType: String {
    case initializeAWSMobileClient
    case signIn
}

protocol AppAction {
    var type: AppActionType { get }
}

struct InitializeAWSMobileClient: AppAction {
    let type: AppActionType = .initializeAWSMobileClient
    let isSignedIn: Bool
    let error: String?

    init(userState: UserState?, error: Error?) {
        isSignedIn = userState == .signedIn
        self.error = error?.localizedDescription
    }
}

struct SignIn: AppAction {
    let type: AppActionType = .signIn
    let username: String
    let password: String
}

//enum Action: Equatable {
//    // MARK: - AWSMobileClient
//
//    case awsMobileClientInitialize(userState: UserState?, error: String?)
//
//    // MARK: - Sign In
//
//    case signIn(username: String, password: String)
//}
