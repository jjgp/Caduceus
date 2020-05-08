//
//  StoreTests.swift
//  CaduceusTests
//
//  Created by Jason Prasad on 5/4/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

@testable import Caduceus
import RxCocoa
import RxSwift
import XCTest

class StoreTests: XCTestCase {
    func testNilInitialState() {
        let sut = makeSut()
        let spy = ObserverSpy(sut.state)
        XCTAssertEqual(spy.values, [nil])
    }

    func testInitialState() {
        let sut = makeSut(initialState: State(0))
        let spy = ObserverSpy(sut.state)
        XCTAssertEqual(spy.values, [State(0)])
    }

    func testActionsUpdateState() {
        let sut = makeSut(initialState: State(0))
        let spy = ObserverSpy(sut.state)
        sut.dispatch.accept(.decrement(1))
        let anotherSpy = ObserverSpy(sut.state)
        sut.dispatch.accept(.increment(1))
        XCTAssertEqual(spy.values, [State(0), State(-1), State(0)])
        XCTAssertEqual(anotherSpy.values, [State(-1), State(0)])
    }

    func testNeverEffect() {
        var zippedSpy: ObserverSpy<Observable<(State?, Action)>>!
        let effect: Store.Effect = { dispatch, state in
            zippedSpy = ObserverSpy(Observable.combineLatest(state, dispatch))
            return .never()
        }
        let sut = Store(
            accumulator: accumulator(state:action:),
            effects: [effect]
        )
        let stateSpy = ObserverSpy(sut.state)
        sut.dispatch.accept(.sideEffect)
        XCTAssertEqual(stateSpy.values, [nil, State(0)])
        XCTAssertEqual(zippedSpy.values.count, 1)
        XCTAssertEqual(zippedSpy.values[0].0, State(0))
        XCTAssertEqual(zippedSpy.values[0].1, Action.sideEffect)
    }

    func testObservableEffect() {
    }
}

// MARK: - Test Helpers

private class ObserverSpy<T: ObservableType> {
    private(set) var values: [T.Element] = []
    private let disposeBag = DisposeBag()

    init(_ observable: T) {
        observable.subscribe(onNext: { [weak self] state in
            self?.values.append(state)
        }).disposed(by: disposeBag)
    }
}

private func accumulator(state: State!, action: Action) -> State {
    var state = state ?? State(0)
    switch action {
    case let .increment(amount):
        state.amount += amount
    case let .decrement(amount):
        state.amount -= amount
    default:
        break
    }
    return state
}

private struct State: Equatable {
    var amount: Int

    init(_ amount: Int) {
        self.amount = amount
    }
}

private enum Action: Equatable {
    case initialize
    case decrement(Int)
    case increment(Int)
    case sideEffect
}

private func makeSut(initialState: State? = nil) -> Store {
    return Store(
        accumulator: accumulator(state:action:),
        initialState: initialState
    )
}

private typealias Store = Caduceus.Store<State, Action>
