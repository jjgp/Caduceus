//
//  Store.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine

class Effect<S: Equatable, A> {
    private var cancellable: AnyCancellable!
    private(set) var effect: Effect!

    init(_ sink: @escaping (AnyPublisher<A, Never>, AnyPublisher<S, Never>) -> AnyCancellable) {
        effect = { [weak self] dispatch, state in
            self?.cancellable = sink(dispatch, state)
            return nil
        }
    }

    init(_ publisher: @escaping Effect) {
        effect = publisher
    }

    init<P: Publisher>(
        _ publisher: @escaping (AnyPublisher<A, Never>, AnyPublisher<S, Never>) -> P
    ) where P.Output == A, P.Failure == Never {
        effect = { publisher($0, $1).eraseToAnyPublisher() }
    }

    typealias Effect = (AnyPublisher<A, Never>, AnyPublisher<S, Never>) -> AnyPublisher<A, Never>?
}

class Store<S: Equatable, A> {
    private var cancellables = [AnyCancellable]()
    let dispatch = PassthroughSubject<A, Never>()
    let effects: [Effect<S, A>]
    let state: AnyPublisher<S, Never>

    init(accumulator: @escaping Accumulator,
         initialState: S,
         effects: [Effect<S, A>] = []) {
        let state = CurrentValueSubject<S, Never>(initialState)
        self.state = state.removeDuplicates().eraseToAnyPublisher()
        cancellables.append(dispatch
            .scan(initialState, accumulator)
            .sink(receiveValue: {
                state.send($0)
            }))
        // Note, this could potentially be dangerous as it leads to a circular publisher. In RxJS and RxSwift, a
        // circular publisher may need to be scheduled on another queue. An Effect that simply returns `dispatch` will
        // result in infinite recursion.
        self.effects = effects
        cancellables.append(
            Publishers.MergeMany(
                effects.compactMap({
                    $0.effect(dispatch.eraseToAnyPublisher(), self.state)
                })
            )
                .sink(receiveValue: { [weak self] in
                    self?.dispatch.send($0)
                })
        )
    }

    typealias Accumulator = (S, A) -> S
}
