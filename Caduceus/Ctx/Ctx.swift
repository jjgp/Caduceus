//
//  Ctx.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

// MARK: - SwiftLint Disable
// swiftlint:disable immutable_ctx

import Combine
import CombineStore

final class Ctx: ObservableObject {
    let constants = Constants()
    let i18n = I18n()
    @Published var store: Store<State, Action>
    let styleGuide = StyleGuide()

    init() {
        store = Store(
            accumulator: accumulator(state:action:),
            initialState: State(),
            effects: [
                /* AWS */
                initializeAWS(constants: constants),
                signInEffect(),
                /* DEBUG */
                loggingEffect()
            ]
        )
    }
}

var ctx = Ctx()
