//
//  RootView.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var ctx: Ctx

    var body: some View {
        Group {
            if ctx.store.state.user.isSignedIn == true {
                Text("Signed In!")
            } else {
                SignInView()
            }
        }
    }
}

#if DEBUG
struct RootViewPreviews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(ctx)
    }
}
#endif
