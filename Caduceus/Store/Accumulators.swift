//
//  Accumulator.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

// MARK: - Accumulator

func accumulator(state: State, action: Action) -> State {
    State(
        user: user(user: state.user, action: action)
    )
}

// MARK: - UserState

private func user(user: User, action: Action) -> User {
    if action.type == .awsMobileClientInitialize, let action = action as? AWSMobileClientInitialize {
        var user = user
        user.isSignedIn = action.isSignedIn
        user.error = action.error
        return user
    }
    return user
}
