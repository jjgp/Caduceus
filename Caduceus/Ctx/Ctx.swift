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
    router: Router,
    store: Store,
    styleGuide: StyleGuide
)

private func createContext() -> Ctx {
    let store = Store(
        accumulator: accumulator(state:action:),
        initialState: State(),
        effects: [
            LoggingEffect(),
            RecorderEffect(),
            SignInEffect()
        ]
    )
    let router = Router(store: store)
    return (
        Constants(),
        I18n(),
        router,
        store,
        StyleGuide()
    )
}

var ctx = createContext()
