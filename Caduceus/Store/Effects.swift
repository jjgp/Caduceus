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

func loggingEffect() -> Effect<State, Action> {
    Effect {
        Publishers.CombineLatest($0, $1)
            .sink(receiveValue: {
                print("Action -> \($0)\n\t|-> State -> \(String(describing: $1))")
            })
    }
}

//struct RecorderEffect: Effect {
//    func effect(dispatch: Observable<Action>, state: Observable<State?>) -> Observable<Action>? {
//        return nil
//    }
//}
