//
//  Actions.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import UIKit

enum Action: Equatable {
    // MARK: - Store
    case initialize

    // MARK: - AppDelegate
    case didFinishLaunchingWithOptions

    // MARK: - Sign In
    case signIn(username: String, password: String)
}

//extension Action: Codable {
//    enum CodingKeys: String, Codable, CodingKey {
//        case initialize
//        case didFinishLaunchingWithOptions
//        case signIn
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        if try container.decodeIfPresent(CodingKeys.self, forKey: .initialize) != nil {
//            self = .initialize
//        }
//        else if try container.decodeIfPresent(CodingKeys.self, forKey: .didFinishLaunchingWithOptions) != nil {
//            self = .didFinishLaunchingWithOptions
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//
//    }
//}
