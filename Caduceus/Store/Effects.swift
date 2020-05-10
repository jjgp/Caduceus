//
//  Effects.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/7/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import Combine
import CombineStore

// MARK: - AWS

func initializeAWS(constants: Constants) -> Effect<State, Action> {
    let awsRegionType: AWSRegionType = constants.cognitoIdentityUserPoolRegion.aws_regionTypeValue()
    let serviceConfiguration = AWSServiceConfiguration(
        region: awsRegionType,
        credentialsProvider: nil
    )
    let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(
        clientId: constants.cognitoIdentityUserPoolAppClientId,
        clientSecret: constants.cognitoIdentityUserPoolAppClientSecret,
        poolId: constants.cognitoIdentityUserPoolId
    )
    AWSCognitoIdentityUserPool.register(with: serviceConfiguration,
                                        userPoolConfiguration: poolConfiguration,
                                        forKey: constants.awsCognitoUserPoolsSignInProviderKey)
    return Effect { _, _ in
        Future<Action, Never> { promise in
            AWSMobileClient.default().initialize {
                promise(.success(InitializeAWSMobileClient(userState: $0, error: $1)))
            }
        }
    }
}

func signInEffect() -> Effect<State, Action> {
    Effect { dispatch, _, bag in
        dispatch
            .filter { $0.type == .signIn }
            .compactMap { $0 as? SignIn }
            .sink(receiveValue: { _ in })
            .store(in: &bag)
    }
}

// MARK: - DEBUG

func loggingEffect<S, A>() -> Effect<S, A> {
    #if DEBUG
    return Effect<S, A> {
        Publishers.Zip($0, $1)
            .sink(receiveValue: {
                debugPrint($0, terminator: "\n\t \\-> ")
                debugPrint($1)
            })
            .store(in: &$2)
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
