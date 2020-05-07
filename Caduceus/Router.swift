//
//  Router.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/5/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import UIKit

class Router {
    let window: UIWindow

    init(attachedTo window: UIWindow) {
        self.window = window
        window.rootViewController = LaunchViewController()
        window.makeKeyAndVisible()
    }
}
