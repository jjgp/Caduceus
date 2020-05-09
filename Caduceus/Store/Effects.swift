//
//  Effects.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/7/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import Combine

func signInEffect() -> Effect<State, Action> {
    Effect { dispatch, _ in
        dispatch
            .filter { $0.type == .signIn }
            .compactMap { $0 as? AWSMobileClientInitialize }
            .sink(receiveValue: {
                debugPrint($0)
            })
    }
}

func loggingEffect<S, A>() -> Effect<S, A> {
    #if DEBUG
    return Effect<S, A> {
        Publishers.CombineLatest($0, $1)
            .sink(receiveValue: {
                debugPrint($0, terminator: "\n\t \\-> ")
                debugPrint($1)
            })
    }
    #else
    return Effect { _, _ in Empty<S, A>() }
    #endif
}

//struct RecorderEffect: Effect {
//    func effect(dispatch: Observable<Action>, state: Observable<State?>) -> Observable<Action>? {
//        return nil
//    }
//}
