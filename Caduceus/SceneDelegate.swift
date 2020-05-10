//
//  SceneDelegate.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/2/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import SwiftUI
import UIKit

extension View {
    func provide<S, A>(store: Store<S, A>) -> some View {
        environment(\.store, store)
    }
}

private struct StoreKey: EnvironmentKey {
    static let defaultValue: Any = ()
}

extension EnvironmentValues {
    var store: Any {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = UIHostingController(
            rootView: RootView().provide(store: ctx.store)
        )
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
