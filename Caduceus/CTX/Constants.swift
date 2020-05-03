//
//  Constants.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: - AWS Constants
    let awsCognitoUserPoolsSignInProviderKey: String
    let cognitoIdentityUserPoolRegion: String
    let cognitoIdentityUserPoolId: String
    let cognitoIdentityUserPoolAppClientId: String
    let cognitoIdentityUserPoolAppClientSecret: String
    let cognitoIdentityPoolId: String

    // MARK: -

    init() {
        let infoDictionary = DKVL(Bundle.main.infoDictionary!)!
        awsCognitoUserPoolsSignInProviderKey = infoDictionary.AWS!.CognitoUserPoolsSigninProviderKey!.stringValue!
        cognitoIdentityUserPoolRegion = infoDictionary.AWS!.CognitoUserPool!.Default!.Region!.stringValue!
        cognitoIdentityUserPoolId = infoDictionary.AWS!.CognitoUserPool!.Default!.PoolId!.stringValue!
        cognitoIdentityUserPoolAppClientId = infoDictionary.AWS!.CognitoUserPool!.Default!.AppClientId!.stringValue!
        cognitoIdentityUserPoolAppClientSecret = infoDictionary.AWS!.CognitoUserPool!.Default!.AppClientSecret!
            .stringValue!
        cognitoIdentityPoolId = infoDictionary.AWS!.CredentialsProvider!.CognitoIdentity!.Default!.PoolId!.stringValue!
    }
}
