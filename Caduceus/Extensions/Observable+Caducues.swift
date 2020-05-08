//
//  Observable+Caducues.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/8/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import RxSwift

extension Observable where Element == Action {
    func ofType(_ actionType: Action.ActionType) -> Observable<Element> {
        filter({ $0.actionType == actionType })
    }
}
