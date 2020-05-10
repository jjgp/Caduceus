//
//  Accumulator.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

// MARK: - Accumulator

func accumulator(state: AppState, action: AppAction) -> AppState {
    AppState(
        user: user(user: state.user, action: action)
    )
}

// MARK: - UserState

private func user(user: User, action: AppAction) -> User {
    if action.type == .initializeAWSMobileClient, let action = action as? InitializeAWSMobileClient {
        var user = user
        user.isSignedIn = action.isSignedIn
        user.error = action.error
        return user
    }
    return user
}
