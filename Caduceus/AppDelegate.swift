//
//  AppDelegate.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/2/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSCognitoIdentityProvider
import AWSMobileClient
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAWSDependencies()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

// MARK: - AWS

extension AppDelegate {
    func setupAWSDependencies() {
        let (constants) = ctx

        #if DEBUG
        AWSDDLog.sharedInstance.logLevel = AWSDDLogLevel.verbose
        #else
        AWSDDLog.sharedInstance.logLevel = AWSDDLogLevel.off
        #endif

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

        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                print("UserState: \(userState.rawValue)")
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
