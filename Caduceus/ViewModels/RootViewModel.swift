//
//  RootViewModel.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine

final class RootViewModel: ObservableObject {
    var cancellable: AnyCancellable!
    @Published var isSignedIn = false

    init(store: Store<State, Action>) {
        cancellable = store
            .state
            .compactMap { $0.user.isSignedIn }
            .removeDuplicates()
            .assign(to: \.isSignedIn, on: self)
    }
}
