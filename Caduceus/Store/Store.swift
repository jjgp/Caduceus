//
//  Store.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import RxSwift

class Store<S, A> {
    private let dispatch: BehaviorSubject<A>
    private let state: Observable<S?>

    init(accumulator: @escaping Accumulator, state: S?, action seed: A) {
        dispatch = BehaviorSubject<A>(value: seed)
        self.state = dispatch.scan(state, accumulator: accumulator)
    }

    typealias Accumulator = (S?, A) -> S
    typealias Middleware = (BehaviorSubject<A>, Observable<S>) -> BehaviorSubject<A>
}

extension Store: ObservableType {
    func dispatch(_ action: A) {
        dispatch.on(.next(action))
    }

    func subscribe<Observer>(
        _ observer: Observer
    ) -> Disposable where Observer: ObserverType, Element == Observer.Element {
        state.subscribe(observer)
    }

    typealias Element = S?
}
