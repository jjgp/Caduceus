//
//  AppDelegate.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/2/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import MobileRTC
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        AWSDDLog.sharedInstance.logLevel = .verbose
        #else
        AWSDDLog.sharedInstance.logLevel = .off
        #endif
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

    func applicationDidBecomeActive(_ application: UIApplication) {
        MobileRTC.shared().appDidBecomeActive()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        AWSDDLog.flushLog()
        MobileRTC.shared().appDidEnterBackgroud()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        AWSDDLog.flushLog()
        MobileRTC.shared().appWillResignActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        AWSDDLog.flushLog()
        MobileRTC.shared().appWillTerminate()
    }
}
