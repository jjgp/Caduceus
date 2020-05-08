//
//  Effects.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/7/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import RxSwift

struct SignInEffect: Effect {
    func effect(dispatch: Observable<Action>, state: Observable<State?>) -> Observable<Action>? {
        _ = dispatch
            .ofType(.signIn)
            .subscribe(onNext: {
                if case let .signIn(username, password) = $0 {
                    AWSMobileClient.default().signIn(username: username, password: password) { signInResult, error in
                        print(signInResult, error)
                    }
                }
            })
        return nil
    }
}

struct LoggingEffect: Effect {
    private let disposeBag = DisposeBag()

    func effect(dispatch: Observable<Action>, state: Observable<State?>) -> Observable<Action>? {
        Observable
            .zip(dispatch, state)
            .subscribe(onNext: {
                print("Action -> \($0)\n\t|-> State -> \(String(describing: $1))")
            })
            .disposed(by: disposeBag)
        return nil
    }
}

struct RecorderEffect: Effect {
    func effect(dispatch: Observable<Action>, state: Observable<State?>) -> Observable<Action>? {
        return nil
    }
}
