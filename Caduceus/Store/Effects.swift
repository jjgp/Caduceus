//
//  Effects.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/7/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import Combine

extension AnyPublisher where Output == Action, Failure == Never {
}

//func signInEffect() -> Effect<State, Action> {
//    Effect { dispatch, _ in
//        dispatch
//            .filter { $0.type == 
//                if case .signIn(_, _) = action {
//                    return true
//                } else {
//                    return false
//                }
//        }.sink(receiveValue: {
//            if case let .signIn(username, password) = $0 {
//                AWSMobileClient.default().signIn(username: username, password: password) { signInResult, error in
//                    print(signInResult, error)
//                }
//            }
//        })
//    }
//}

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
