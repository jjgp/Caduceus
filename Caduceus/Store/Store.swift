//
//  Store.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import RxCocoa
import RxSwift

class Store<S, A> {
    public let dispatch = PublishRelay<A>()
    private let disposeBag = DisposeBag()
    public let state: BehaviorRelay<S?>

    init(
        accumulator: @escaping Accumulator,
        initialState: S? = nil,
        effects: [Effect] = []
    ) {
        state = BehaviorRelay(value: initialState)
        dispatch
            .scan(initialState, accumulator: accumulator)
            .bind(to: state)
            .disposed(by: disposeBag)

//        _ = effects.first?(Observable.zip(self.state, dispatch), dispatch)
//
//        effects
//            .reversed()
//            .reduce(dispatch) { dispatchFunction, effect in
//                    // If the store get's deinitialized before the middleware is complete; drop
//                    // the action without dispatching.
//                    let dispatch: (Action) -> Void = { [weak self] in self?.dispatch($0) }
//                    let getState = { [weak self] in self?.state }
//                    return middleware(dispatch, getState)(dispatchFunction)
//            }
    }

    typealias Accumulator = (S?, A) -> S
    typealias Effect = (PublishRelay<A>, BehaviorRelay<S?>) -> (PublishRelay<A>) -> PublishRelay<A>
}
