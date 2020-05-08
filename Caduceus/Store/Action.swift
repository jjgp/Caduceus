//
//  Actions.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import UIKit

enum ActionType: String {
    case awsMobileClientInitialize
}

protocol Action {
    var type: ActionType { get }
}

struct AWSMobileClientInitialize: Action {
    let type: ActionType = .awsMobileClientInitialize
    let isSignedIn: Bool
    let error: String?

    init(userState: UserState?, error: Error?) {
        isSignedIn = userState == .signedIn
        self.error = error?.localizedDescription
    }
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
