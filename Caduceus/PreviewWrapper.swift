//
//  PreviewWrapper.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/2/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

#if DEBUG
import SwiftUI

extension UIViewController {
    var previewWrapper: PreviewWrapper {
        .wrapped(self)
    }
}

enum PreviewWrapper: UIViewControllerRepresentable {
    case wrapped(UIViewController)

    func makeUIViewController(context: Context) -> UIViewController {
        if case let .wrapped(viewController) = self {
            return viewController
        } else {
            fatalError("Encountered an unreachable PreviewWrapper case")
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
#endif
