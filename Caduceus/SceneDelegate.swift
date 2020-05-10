//
//  SceneDelegate.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/2/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import CombineStore
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        let store = Store(
            accumulator: accumulator(state:action:),
            initialState: State(),
            effects: [
                /* AWS */
                .initializeAWS(),
                .signInEffect(),
                /* DEBUG */
                .loggingEffect()
            ]
        )
        let rootView = MapStore(
            store,
            transform: RootViewModel.init,
            content: RootView.init
        )
        self.window?.rootViewController = UIHostingController(rootView: rootView)
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
