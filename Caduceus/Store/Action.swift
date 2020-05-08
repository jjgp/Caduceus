//
//  Actions.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import UIKit

enum Action: Equatable {
    // MARK: - AWSMobileClient

    case awsMobileClientInitialize(userState: UserState?, error: String?)

    // MARK: - Sign In

    case signIn(username: String, password: String)
}
