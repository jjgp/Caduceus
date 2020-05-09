//
//  SignInViewModel.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine

final class SignInViewModel: ObservableObject {
    var cancellable: AnyCancellable!

    init(store: Store<State, Action>) {
    }

    func signInAction() {
    }
}
