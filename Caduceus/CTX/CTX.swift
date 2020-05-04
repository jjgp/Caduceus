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
    AppCoordinator,
    Constants,
    I10n,
    StyleGuide
)

var ctx = (
    constants: Constants(),
    coordinator: AppCoordinator(),
    i10n: I10n(),
    styleGuide: StyleGuide()
)
