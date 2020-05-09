//
//  PreviewWrapper.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/2/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

#if DEBUG
import SwiftUI

extension UIView {
    var previewWrapper: UIViewPreviewWrapper {
        UIViewPreviewWrapper(view: self)
    }
}

struct UIViewPreviewWrapper: UIViewRepresentable {
    let view: UIView

    func makeUIView(context: Context) -> UIView {
        view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension UIViewController {
    var previewWrapper: UIViewControllerPreviewWrapper {
        UIViewControllerPreviewWrapper(viewController: self)
    }
}

struct UIViewControllerPreviewWrapper: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
#endif
