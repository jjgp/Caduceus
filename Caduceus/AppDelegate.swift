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
        launchAWS()
        return true
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    // MARK: - Lifecycle

    func applicationDidEnterBackground(_ application: UIApplication) {
        AWSDDLog.flushLog()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        AWSDDLog.flushLog()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        AWSDDLog.flushLog()
    }
}

extension AppDelegate {
    // MARK: - AWS

    private func launchAWS() {
        let awsRegionType: AWSRegionType = ctx.constants.cognitoIdentityUserPoolRegion.aws_regionTypeValue()
        let serviceConfiguration = AWSServiceConfiguration(
            region: awsRegionType,
            credentialsProvider: nil
        )
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(
            clientId: ctx.constants.cognitoIdentityUserPoolAppClientId,
            clientSecret: ctx.constants.cognitoIdentityUserPoolAppClientSecret,
            poolId: ctx.constants.cognitoIdentityUserPoolId
        )
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration,
                                            userPoolConfiguration: poolConfiguration,
                                            forKey: ctx.constants.awsCognitoUserPoolsSignInProviderKey)
        AWSMobileClient.default().initialize {
            ctx.store.dispatch.send(AWSMobileClientInitialize(userState: $0, error: $1))
        }
    }
}
