//
//  Store.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

import RxCocoa
import RxSwift

protocol Effect {
    func effect(dispatch: Observable<Action>, state: Observable<State?>) -> Observable<Action>?
}

class Store {
    public let dispatch = PublishRelay<Action>()
    private let disposeBag = DisposeBag()
    private let effects: [Effect]
    public let state: Observable<State?>

    init(
        accumulator: @escaping Accumulator,
        initialState: State? = nil,
        effects: [Effect] = []
    ) {
        let state = BehaviorRelay(value: initialState)
        self.state = state.asObservable()
        dispatch
            .observeOn(MainScheduler.instance)
            .scan(initialState, accumulator: accumulator)
            .bind(to: state)
            .disposed(by: disposeBag)
        self.effects = effects
        Observable
            .merge(effects.compactMap({
                $0.effect(dispatch: dispatch.asObservable(), state: self.state.distinctUntilChanged())
            }))
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: dispatch)
            .disposed(by: disposeBag)
    }

    typealias Accumulator = (State?, Action) -> State
}
