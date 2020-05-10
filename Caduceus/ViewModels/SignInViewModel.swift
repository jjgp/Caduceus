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
    let store: Store<AppState, AppAction>
    @Published var isFormValid = false

    init(store: Store<AppState, AppAction>) {
        self.store = store
    }

    func signInAction() {
        store.send(SignIn(username: "", password: ""))
    }
}
