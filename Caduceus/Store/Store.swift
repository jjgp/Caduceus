//
//  Store.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine

final class Effect<S, A> {
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

final class Store<S, A>: ObservableObject {
    private var cancellableSet: Set<AnyCancellable> = []
    let dispatch = PassthroughSubject<A, Never>()
    let effects: [Effect<S, A>]
    @Published private(set) var state: S

    init(accumulator: @escaping Accumulator,
         initialState: S,
         effects: [Effect<S, A>] = []) {
        state = initialState
        self.effects = effects
        dispatch
            .scan(initialState, accumulator)
            .assign(to: \.state, on: self)
            .store(in: &cancellableSet)
        // Note, this could potentially be dangerous as it leads to a circular publisher. In RxJS and RxSwift, a
        // circular publisher may need to be scheduled on another queue. An Effect that simply returns `dispatch` will
        // result in infinite recursion.
        Publishers.MergeMany(
            effects.compactMap({
                $0.effect(dispatch.eraseToAnyPublisher(), $state.dropFirst().eraseToAnyPublisher())
            })
        )
            .sink(receiveValue: { [weak self] in
                self?.dispatch.send($0)
            })
            .store(in: &cancellableSet)
    }

    typealias Accumulator = (S, A) -> S
}
