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

//        _ = effects
//            .reversed()
//            .reduce(dispatch) { accumulated, effect in
//
//        }
    }

    typealias Accumulator = (S?, A) -> S
    typealias Effect = (Observable<A>, Observable<S?>) -> Observable<A>
}
