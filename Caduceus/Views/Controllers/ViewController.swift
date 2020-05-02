//
//  ViewController.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/2/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

#if DEBUG
import SwiftUI

struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ViewController().previewWrapper
    }
}
#endif
