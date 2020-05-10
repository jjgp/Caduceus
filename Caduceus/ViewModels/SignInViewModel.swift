//
//  SignInViewModel.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine
import CombineStore

final class SignInViewModel: ObservableObject {
    let store: Store<State, Action>

    init(store: Store<State, Action>) {
        self.store = store
    }

    func signInAction() {
        store.send(SignIn(username: "", password: ""))
    }
}
