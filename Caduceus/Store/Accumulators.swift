//
//  Accumulator.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

func awsAccumulator(state: State.AWS?, action: Action) -> State.AWS {
    var aws = state ?? State.AWS()
    if case let .awsMobileClientInitialize(userState, error) = action {
        aws.userState = userState
        aws.error = error
    }
    return aws
}

func accumulator(state: State?, action: Action) -> State {
    State(
        aws: awsAccumulator(state: state?.aws, action: action)
    )
}
