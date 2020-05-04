//
//  StyleGuide.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import UIKit

struct StyleGuide {
    let colors = Colors()
    let pixels = Pixels()
}

struct Colors {
    var background: UIColor { .white }
    var buttonColor: UIColor { .systemBlue }
    var buttonFont: UIColor { .white }
}

struct Pixels {
    var buttonRounding: CGFloat = 22
    var fieldHeight: CGFloat = 44
    var fieldSpacing: CGFloat = 18
}
