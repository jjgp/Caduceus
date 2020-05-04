//
//  Ctx.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

// MARK: - SwiftLint Disable
// swiftlint:disable immutable_ctx

typealias Ctx = (
    constants: Constants,
    i18n: I18n,
    store: Store,
    styleGuide: StyleGuide
)

var ctx: Ctx = (
    Constants(),
    I18n(),
    Store(),
    StyleGuide()
)
