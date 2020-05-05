//
//  Box.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

enum Box<T> {
    case some(T)
    case none

    init(_ value: T?) {
        self = value != nil ? .some(value!) : .none
    }

    var opened: T? {
        switch self {
        case let .some(value):
            return value
        default:
            return nil
        }
    }
}
