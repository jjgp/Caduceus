//
//  Effect.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/9/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import Combine

final class Effect<S, A> {
    private var cancellableBag: Set<AnyCancellable>!
    private(set) var effect: Effect!

    init(_ sink: @escaping (AnyPublisher<A, Never>, AnyPublisher<S, Never>, inout Set<AnyCancellable>) -> Void) {
        effect = { [weak self] dispatch, state in
            guard let self = self else {
                return nil
            }
            self.cancellableBag = []
            sink(dispatch, state, &self.cancellableBag)
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
