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

extension Effect where S == State, A == Action {
    // MARK: - AWS

    static func initializeAWS() -> Self {
        let infoDictionary = DKVL(Bundle.main.infoDictionary!)!
        let awsCognitoUserPoolsSignInProviderKey = infoDictionary.AWS!.CognitoUserPoolsSigninProviderKey!.stringValue!
        let cognitoIdentityUserPoolRegion = infoDictionary.AWS!.CognitoUserPool!.Default!.Region!.stringValue!
        let cognitoIdentityUserPoolId = infoDictionary.AWS!.CognitoUserPool!.Default!.PoolId!.stringValue!
        let cognitoIdentityUserPoolAppClientId = infoDictionary.AWS!.CognitoUserPool!.Default!.AppClientId!.stringValue!
        let cognitoIdentityUserPoolAppClientSecret = infoDictionary.AWS!.CognitoUserPool!.Default!.AppClientSecret!
            .stringValue!

        let awsRegionType: AWSRegionType = cognitoIdentityUserPoolRegion.aws_regionTypeValue()
        let serviceConfiguration = AWSServiceConfiguration(
            region: awsRegionType,
            credentialsProvider: nil
        )
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(
            clientId: cognitoIdentityUserPoolAppClientId,
            clientSecret: cognitoIdentityUserPoolAppClientSecret,
            poolId: cognitoIdentityUserPoolId
        )
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration,
                                            userPoolConfiguration: poolConfiguration,
                                            forKey: awsCognitoUserPoolsSignInProviderKey)
        return Self { _, _ in
            Future<Action, Never> { promise in
                AWSMobileClient.default().initialize {
                    promise(.success(InitializeAWSMobileClient(userState: $0, error: $1)))
                }
            }
        }
    }

    static func signInEffect() -> Self {
        Self { dispatch, _, bag in
            dispatch
                .filter { $0.type == .signIn }
                .compactMap { $0 as? SignIn }
                .sink(receiveValue: { _ in })
                .store(in: &bag)
        }
    }
}

extension Effect where S == State, A == Action {
    // MARK: - DEBUG

    static func loggingEffect() -> Self {
        #if DEBUG
        return Self {
            Publishers.Zip($0, $1)
                .sink(receiveValue: {
                    debugPrint($0, terminator: "\n\t \\-> ")
                    debugPrint($1)
                })
                .store(in: &$2)
        }
        #else
        return Self { _, _ in Empty<S, A>() }
        #endif
    }

    //struct RecorderEffect: Effect {
    //    func effect(dispatch: Observable<Action>, state: Observable<State?>) -> Observable<Action>? {
    //        return nil
    //    }
    //}
}
