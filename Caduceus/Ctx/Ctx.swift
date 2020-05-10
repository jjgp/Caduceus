//
//  Ctx.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

// MARK: - SwiftLint Disable

final class Ctx {
    let i18n = I18n()
    let styleGuide = StyleGuide()

    init() {}
}

var ctx = Ctx()
