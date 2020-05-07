//
//  Actions.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import UIKit
//
//  Action.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

enum Action: Equatable {
    // MARK: - Store
    case initialize

    // MARK: - AWSMobileClient
    case awsMobileClientInitialize(userState: String?, error: String?)

    // MARK: - Sign In
    case signIn(username: String?, password: String?)
}

extension Action: Codable {
    /// [Attribution](https://will.townsend.io/2019/codable-enums-in-swift)
    private enum Discriminator: String, Codable, CodingKey {
        case initialize
        case awsMobileClientInitialize
        case signIn
    }

    enum CodingKeys: String, Codable, CodingKey {
        case discriminator
        case awsMobileClientInitializeUserState
        case awsMobileClientInitializeError
        case signInUsername
        case signInPassword
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(Discriminator.self, forKey: .discriminator)

        switch discriminator {
        case .initialize:
            self = .initialize
        case .awsMobileClientInitialize:
            self = .awsMobileClientInitialize(
                userState: try? container.decode(String.self, forKey: .awsMobileClientInitializeUserState),
                error: try? container.decode(String.self, forKey: .awsMobileClientInitializeError)
            )
        case .signIn:
            self = .signIn(
                username: try container.decode(String.self, forKey: .signInUsername),
                password: try container.decode(String.self, forKey: .signInPassword)
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .initialize:
            try container.encode(Discriminator.initialize, forKey: .discriminator)
        case let .awsMobileClientInitialize(userState, error):
            try container.encode(Discriminator.awsMobileClientInitialize, forKey: .discriminator)
            try container.encode(userState, forKey: .awsMobileClientInitializeUserState)
            try container.encode(error, forKey: .awsMobileClientInitializeError)
        case let .signIn(username, password):
            try container.encode(Discriminator.signIn, forKey: .discriminator)
            try container.encode(username, forKey: .signInUsername)
            try container.encode(password, forKey: .signInPassword)
        }
    }
}
