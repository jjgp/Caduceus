//
//  AppCoordinator.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import UIKit

protocol AppCoordinatorType {
    // MARK: - SceneDelegate
    func attactToWindow(_ window: UIWindow)

    // MARK: - AppDelegate
    func startWithLaunchOptions(_ options: [UIApplication.LaunchOptionsKey: Any]?)
}

class AppCoordinator: AppCoordinatorType {
    weak var window: UIWindow?
}

extension AppCoordinator {
    func attactToWindow(_ window: UIWindow) {
        self.window = window
        self.window?.rootViewController = LaunchViewController()
        self.window?.makeKeyAndVisible()
    }
}

extension AppCoordinator {
    func startWithLaunchOptions(_ options: [UIApplication.LaunchOptionsKey: Any]?) {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                print("UserState: \(userState.rawValue)")
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
