//
//  Store.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine

final class Store<S, A>: ObservableObject {
    private var cancellableBag: Set<AnyCancellable> = []
    private let dispatch: PassthroughSubject<A, Never>
    private let effects: [Effect<S, A>]
    @Published private(set) var state: S

    init(accumulator: @escaping Accumulator,
         initialState: S,
         effects: [Effect<S, A>] = []) {
        let dispatch = PassthroughSubject<A, Never>()
        self.dispatch = dispatch
        state = initialState
        self.effects = effects
        dispatch
            .scan(initialState, accumulator)
            .assign(to: \.state, on: self)
            .store(in: &cancellableBag)
        // Note, this could potentially be dangerous as it leads to a circular publisher. In RxJS and RxSwift, a
        // circular publisher may need to be scheduled on another queue. An Effect that simply returns `dispatch` will
        // result in infinite recursion.
        Publishers.MergeMany(
            effects.compactMap({
                $0.effect(dispatch.eraseToAnyPublisher(), $state.eraseToAnyPublisher())
            })
        )
            .sink(receiveValue: dispatch.send)
            .store(in: &cancellableBag)
    }

    func dispatch(_ action: A) {
        dispatch.send(action)
    }

    typealias Accumulator = (S, A) -> S
}
