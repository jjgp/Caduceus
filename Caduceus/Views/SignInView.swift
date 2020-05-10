//
//  SignInView.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject private var viewModel: SignInViewModel

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
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
                Button(action: viewModel.signInAction) {
                    Text(verbatim: .t(\.signIn))
                }
            }
        }
    }
}

//#if DEBUG
//struct SignInViewPreviews: PreviewProvider {
//    static var previews: some View {
//        SignInView().environmentObject(ctx)
//    }
//}
//#endif
