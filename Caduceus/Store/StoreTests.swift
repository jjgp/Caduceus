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

//    func testSideEffect() {
//        let effect: Store.Effect = { dispatch, state, next in
//            return PublishRelay<Action>()
//        }
//        let sut = Store(
//            accumulator: accumulator(state:action:),
//            effects: [effect]
//        )
//        sut.dispatch.accept(.sideEffect)
//    }
}

// MARK: - Test Helpers

extension StoreTests {
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
        switch action {
        case let .increment(amount):
            return State(state.amount + amount)
        case let .decrement(amount):
            return State(state.amount - amount)
        default:
            return State(0)
        }
    }

    private struct State: Equatable {
        let amount: Int
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
}

private func ==<T: Equatable>(lhs: (T, T), rhs: (T, T)) -> Bool {
    return (lhs.0 == rhs.0) && (lhs.1 == rhs.1)
}
