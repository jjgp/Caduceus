//
//  Router.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/7/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import RxSwift
import UIKit

class Router {
    private let disposeBag = DisposeBag()
    private weak var window: UIWindow?

    init(store: Store) {
        store.state.subscribe(onNext: onNext).disposed(by: disposeBag)
    }

    func onNext(state: State?) {
        switch state?.aws.userState {
        case .signedOut:
            let signInViewController = SignInViewController()
            signInViewController.modalPresentationStyle = .fullScreen
            self.window?.rootViewController?.present(signInViewController, animated: true, completion: nil)
        default:
            break
        }
    }
}

extension Router {
    func attach(to window: UIWindow) {
        self.window = window
        self.window?.rootViewController = LaunchViewController()
        self.window?.makeKeyAndVisible()
    }
}
