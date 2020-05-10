//
//  RootView.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import CombineStore
import SwiftUI

struct RootView: View {
    @ObservedObject private var viewModel: RootViewModel

    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if viewModel.isSignedIn == true {
                Text("Signed In!")
            } else {
                MapStore(SignInViewModel.init, content: SignInView.init)
            }
        }
    }
}

//#if DEBUG
//struct RootViewPreviews: PreviewProvider {
//    static var previews: some View {}
//}
//#endif
