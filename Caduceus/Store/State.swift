//
//  State.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import Foundation

struct State: Equatable {
    struct AWS: Equatable {
        var userState: UserState?
        var error: String?
    }

    let aws: AWS

    init(aws: AWS = AWS()) {
        self.aws = aws
    }
}
