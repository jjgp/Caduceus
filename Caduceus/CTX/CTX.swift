//
//  CTX.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

// MARK: - SwiftLint Disable
// swiftlint:disable immutable_ctx

typealias CTX = (
    Colors,
    Constants,
    I10n
)

var ctx = (
    colors: Colors(),
    constants: Constants(),
    i10n: I10n()
)
