//
//  Actions.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import UIKit

enum Action: Equatable {
    case unknown

    // MARK: - Store
    case initialize

    // MARK: - AppDelegate
    case didFinishLaunchingWithOptions

    // MARK: - Sign In
    case signIn(username: String, password: String)
}

extension Action: Codable {
    /// [Attribution](https://will.townsend.io/2019/codable-enums-in-swift)
    private enum Discriminator: String, Codable, CodingKey {
        case unknown
        case initialize
        case didFinishLaunchingWithOptions
        case signIn
    }

    enum CodingKeys: String, Codable, CodingKey {
        case discriminator
        case signInUsername
        case signInPassword
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(Discriminator.self, forKey: .discriminator)

        switch discriminator {
        case .initialize:
            self = .initialize
        case .didFinishLaunchingWithOptions:
            self = .didFinishLaunchingWithOptions
        case .signIn:
            self = .signIn(
                username: try container.decode(String.self, forKey: .signInUsername),
                password: try container.decode(String.self, forKey: .signInPassword)
            )
        default:
            self = .unknown
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .initialize:
            try container.encode(Discriminator.initialize, forKey: .discriminator)
        case .didFinishLaunchingWithOptions:
            try container.encode(Discriminator.didFinishLaunchingWithOptions, forKey: .discriminator)
        case let .signIn(username, password):
            try container.encode(Discriminator.signIn, forKey: .discriminator)
            try container.encode(username, forKey: .signInUsername)
            try container.encode(password, forKey: .signInPassword)
        default:
            try container.encode(Discriminator.unknown, forKey: .discriminator)
        }
    }
}
