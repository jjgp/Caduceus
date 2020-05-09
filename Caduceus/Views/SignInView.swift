//
//  SignInView.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject private var signInViewModel: SignInViewModel

    init(store: Store<State, Action>) {
        signInViewModel = SignInViewModel(store: store)
    }

    var body: some View {
        Form {
            Section(header: Text(verbatim: .t(\.username))) {
                Text("Hello, World!")
            }
            Section(header: Text(verbatim: .t(\.password))) {
                Text("Hello, World!")
            }
            Section {
                Button(action: signInViewModel.signInAction) {
                    Text(verbatim: .t(\.signIn))
                }
            }
        }
    }
}

#if DEBUG
struct SignInViewPreviews: PreviewProvider {
    static var previews: some View {
        SignInView(store: ctx.store)
    }
}
#endif
