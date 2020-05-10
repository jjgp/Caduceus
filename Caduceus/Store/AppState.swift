//
//  AppState.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Foundation

// MARK: - State

struct AppState: Equatable {
    let user: User

    init(user: User = User()) {
        self.user = user
    }
}

// MARK: - UserState

struct User: Equatable {
    var isSignedIn: Bool?
    var error: String?
}
