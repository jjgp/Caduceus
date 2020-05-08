//
//  Actions.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import AWSMobileClient
import UIKit

enum Action: Equatable {
    // MARK: - AWSMobileClient

    case awsMobileClientInitialize(userState: UserState?, error: String?)

    // MARK: - Sign In

    case signIn(username: String, password: String)
}

extension Action {
    var actionType: ActionType {
        switch self {
        case .awsMobileClientInitialize:
            return .awsMobileClientInitialize
        case .signIn:
            return .signIn
        }
    }
}

extension Action: Codable {
    // MARK: - Codable

    /// [Attribution](https://will.townsend.io/2019/codable-enums-in-swift)
    enum ActionType: String, Codable, CodingKey {
        case awsMobileClientInitialize
        case signIn
    }

    enum CodingKeys: String, Codable, CodingKey {
        case actionType
        case awsMobileClientInitializeUserState
        case awsMobileClientInitializeError
        case signInUsername
        case signInPassword
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(ActionType.self, forKey: .actionType)

        switch discriminator {
        case .awsMobileClientInitialize:
            let userState = (try? container.decode(String.self, forKey: .awsMobileClientInitializeUserState))
                .flatMap { UserState(rawValue: $0) }
            self = .awsMobileClientInitialize(
                userState: userState,
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
        try container.encode(actionType, forKey: .actionType)

        switch self {
        case let .awsMobileClientInitialize(userState, error):
            try container.encode(userState?.rawValue, forKey: .awsMobileClientInitializeUserState)
            try container.encode(error, forKey: .awsMobileClientInitializeError)
        case let .signIn(username, password):
            try container.encode(username, forKey: .signInUsername)
            try container.encode(password, forKey: .signInPassword)
        }
    }
}
