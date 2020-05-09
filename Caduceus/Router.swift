//
//  Router.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/7/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

class Router {
    private var cancellable: AnyCancellable!
    private weak var window: UIWindow?
}

extension Router {
    func attach(to window: UIWindow) {
        self.window = window
        self.window?.rootViewController = UIHostingController(rootView: RootView())
        self.window?.makeKeyAndVisible()
    }
}

extension Router {
    func effect() -> Effect<State, Action> {
        Effect { _, _ in
            Empty<Action, Never>()
        }
//        if state.user.isSignedIn == false {
//            let signInViewController = SignInViewController()
//            signInViewController.modalPresentationStyle = .fullScreen
//            self.window?.rootViewController?.present(signInViewController, animated: true, completion: nil)
//        }
    }
}
