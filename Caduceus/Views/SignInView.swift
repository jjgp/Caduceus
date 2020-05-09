//
//  SignInView.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        Section(header: Text(verbatim: .t(\.username))) {
            Text("Hello, World!")
        }
    }
}

#if DEBUG
struct SignInViewPreviews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
#endif
