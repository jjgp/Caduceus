//
//  State.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Foundation

struct State: Equatable {
    let foobar: String

    init(foobar: String = "foobar") {
        self.foobar = foobar
    }
}
