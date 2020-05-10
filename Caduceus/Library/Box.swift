//
//  Box.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/10/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Foundation

final class Box<T> {
    var value: T

    init(value: T) {
        self.value = value
    }
}
