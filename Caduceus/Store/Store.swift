//
//  Store.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import RxSwift

func accumulator(state: State, action: Action) -> State {
    if action == Action.didFinishLaunchingWithOptions {
        return State(foobar: "quux")
    } else {
        return State(foobar: "barbaz")
    }
}

class Store: ObservableType {
    private let dispatch = BehaviorSubject<Action>(value: .initialize)
    private let disposeBag: DisposeBag = DisposeBag()
    private let store: Observable<State>

    init(accumulator: @escaping (State, Action) -> State = accumulator) {
        store = dispatch.scan(State(), accumulator: accumulator)
    }

    func dispatch(_ action: Action, value: Codable? = nil) {
        dispatch.on(.next(action))
    }

    func subscribe<Observer>(
        _ observer: Observer
    ) -> Disposable where Observer: ObserverType, Element == Observer.Element {
        store.subscribe(observer)
    }

    typealias Element = State
}
