//
//  I10n.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Foundation

extension String {
    static func t(_ key: KeyPath<I10n, String>, _ arguments: CVarArg...) -> String {
        return ctx.i10n[keyPath: key]
    }
}

struct I10n {
    var password: String { NSLocalizedString("Password", comment: "") }
    var signIn: String { NSLocalizedString("Sign In", comment: "") }
    var username: String { NSLocalizedString("Username", comment: "") }
}
