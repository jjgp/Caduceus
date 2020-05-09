//
//  RootView.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import SwiftUI

struct RootView: View {
    let store: Store<State, Action>
    @ObservedObject private var rootViewModel: RootViewModel

    init(store: Store<State, Action>) {
        self.store = store
        rootViewModel = RootViewModel(store: store)
    }

    var body: some View {
        Group {
            if rootViewModel.isSignedIn {
                Text("Signed In!")
            } else {
                SignInView(store: store)
            }
        }
    }
}

#if DEBUG
struct RootViewPreviews: PreviewProvider {
    static var previews: some View {
        RootView(store: ctx.store)
    }
}
#endif
